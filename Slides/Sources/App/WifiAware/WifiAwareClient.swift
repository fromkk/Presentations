import Foundation
import Network
import OSLog
import WiFiAware

#if os(iOS)
enum WifiAwareConstants {
  static let serviceName: String = "_presentations._udp"
}

extension WAPublishableService {
  public static var presentationService: WAPublishableService {
    allServices[WifiAwareConstants.serviceName]!
  }
}

extension WASubscribableService {
  public static var presentationService: WASubscribableService {
    allServices[WifiAwareConstants.serviceName]!
  }
}

extension WAPairedDevice {
  var displayName: String {
    let displayName = self.name ?? self.pairingInfo?.pairingName ?? ""
    return "\(displayName) (\(self.pairingInfo?.vendorName ?? ""))"
  }
}

extension WAPerformanceReport {
  var display: String {
    return
      "[\(self.timestamp)] Signal Strength: \(self.signalStrength?.description ?? "-"), Transmit Latency: \(self.transmitLatency)"
  }
}

let appPerformanceMode: WAPerformanceMode = .realtime
let appAccessCategory: WAAccessCategory = .bestEffort
let appServiceClass: NWParameters.ServiceClass = appAccessCategory.serviceClass

extension WAAccessCategory {
  var serviceClass: NWParameters.ServiceClass {
    switch self {
    case .bestEffort: .bestEffort
    case .background: .background
    case .interactiveVideo: .interactiveVideo
    case .interactiveVoice: .interactiveVoice
    default: .bestEffort
    }
  }
}

enum ConnectionState: Hashable, Sendable {
  case idle
  case connecting
  case connected
  case cancelled
  case failed
}

@MainActor
protocol WifiAwareClientDelegate: AnyObject {
  func receivedEvent(_ event: P2PEvent)
  func connectionStateChanged(_ connectionState: ConnectionState)
}

@available(iOS 26.0, *)
@MainActor
@Observable
final class WifiAwareClient {
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: "WifiAwareClient"
  )
  weak var delegate: WifiAwareClientDelegate?
  var pairedDevices: [WAPairedDevice] = []

  private var connectionManager: ConnectionManager?
  private var networkManager: NetworkManager?
  private var listenerTask: Task<Void, Error>?
  private var browserTask: Task<Void, Error>?
  private var eventMonitorTask: Task<Void, Never>?

  var connectionState: ConnectionState = .idle
  var receivedEvent: P2PEvent?
  var connectedDevices: [WAPairedDevice] = []

  init() {
    Task {
      for try await devices in WAPairedDevice.allDevices {
        self.pairedDevices = Array(devices.values)
      }
    }
  }

  // MARK: - Start Advertise (Publisher)

  func startAdvertise() async throws {
    logger.info("\(#function)")

    // Clean up existing instances
    stopAll()

    let connectionManager = ConnectionManager()
    let networkManager = NetworkManager(connectionManager: connectionManager)

    self.connectionManager = connectionManager
    self.networkManager = networkManager

    // Start monitoring events
    startEventMonitoring(
      networkManager: networkManager,
      connectionManager: connectionManager
    )

    // Start listener
    listenerTask = Task {
      try await networkManager.listen()
    }
  }

  // MARK: - Start Browse (Subscriber)

  func startBrowse() async throws {
    logger.info("\(#function)")

    // Clean up existing instances
    stopAll()

    let connectionManager = ConnectionManager()
    let networkManager = NetworkManager(connectionManager: connectionManager)

    self.connectionManager = connectionManager
    self.networkManager = networkManager

    // Start monitoring events
    startEventMonitoring(
      networkManager: networkManager,
      connectionManager: connectionManager
    )

    // Start browser
    browserTask = Task {
      try await networkManager.browse()
    }
  }

  // MARK: - Event Monitoring

  private func startEventMonitoring(
    networkManager: NetworkManager,
    connectionManager: ConnectionManager
  ) {
    eventMonitorTask = Task {
      await withTaskGroup(of: Void.self) { group in
        // Monitor local events from NetworkManager
        group.addTask {
          for await event in networkManager.localEvents {
            await MainActor.run {
              self.handleLocalEvent(event)
            }
          }
        }

        // Monitor network events from ConnectionManager
        group.addTask {
          for await event in connectionManager.networkEvents {
            await MainActor.run {
              self.logger.info("Received network event: \(event)")
              self.receivedEvent = event
              self.delegate?.receivedEvent(event)
            }
          }
        }

        // Monitor connection local events from ConnectionManager
        group.addTask {
          for await event in connectionManager.localEvents {
            await MainActor.run {
              self.handleLocalEvent(event)
            }
          }
        }
      }
    }
  }

  private func handleLocalEvent(_ event: LocalEvent) {
    logger.info("Local event: \(String(describing: event))")

    switch event {
    case .listenerRunning, .browserRunning:
      connectionState = .connecting

    case .connecting:
      connectionState = .connecting

    case .connection(let connectionEvent):
      handleConnectionEvent(connectionEvent)

    case .listenerStopped(let error), .browserStopped(let error):
      if let error = error {
        logger.error("Connection stopped with error: \(error.localizedDescription)")
        connectionState = .failed
      } else {
        connectionState = .cancelled
      }
    }

    delegate?.connectionStateChanged(connectionState)
  }

  private func handleConnectionEvent(_ event: ConnectionEvent) {
    switch event {
    case .ready(let device, let detail):
      logger.info("Connection ready with device: \(device.displayName)")
      if !connectedDevices.contains(where: { $0.id == device.id }) {
        connectedDevices.append(device)
      }
      connectionState = .connected

    case .stopped(let device, let id, let error):
      logger.info("Connection stopped with device: \(device.displayName)")
      connectedDevices.removeAll(where: { $0.id == device.id })
      if let error = error {
        logger.error("Connection error: \(error.localizedDescription)")
        connectionState = .failed
      } else {
        connectionState = connectedDevices.isEmpty ? .idle : .connected
      }

    case .performance(let device, let detail):
      if let report = detail.performanceReport {
        logger.debug("Performance for \(device.displayName): \(report.display)")
      }
    }
  }

  // MARK: - Send

  func send(_ event: P2PEvent) async throws {
    logger.info("\(#function) event \(event)")
    guard let networkManager = networkManager else {
      logger.warning("NetworkManager is not initialized")
      return
    }
    await networkManager.sendToAll(event)
  }

  // MARK: - Stop

  func stopAll() {
    logger.info("\(#function)")

    listenerTask?.cancel()
    browserTask?.cancel()
    eventMonitorTask?.cancel()

    listenerTask = nil
    browserTask = nil
    eventMonitorTask = nil
    connectionManager = nil
    networkManager = nil

    connectedDevices.removeAll()
    connectionState = .idle
  }
}
#endif
