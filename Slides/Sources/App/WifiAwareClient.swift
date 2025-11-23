import Foundation
import Network
import OSLog
import WiFiAware

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

  var connection:
    NetworkConnection<
      Coder<P2PEvent, P2PEvent, NetworkJSONCoder>
    >?

  var connectionState: ConnectionState = .idle

  var receivedEvent: P2PEvent?

  init() {
    Task {
      for try await devices in WAPairedDevice.allDevices {
        self.pairedDevices = Array(devices.values)
      }
    }
  }

  func publishListener() async throws {
    logger.info("\(#function)")
    try await NetworkListener(
      for: .wifiAware(
        .connecting(to: .presentationService, from: .allPairedDevices)
      ),
      using: .parameters {
        Coder(
          receiving: P2PEvent.self,
          sending: P2PEvent.self,
          using: NetworkJSONCoder()
        ) {
          UDP()
        }
      }
      .wifiAware { $0.performanceMode = .realtime }
      .serviceClass(appServiceClass)
    )
    .onStateUpdate({ [weak self] listener, state in
      self?.logger.info("publishListener listener \(listener.debugDescription) state \(String(describing: state))")
      switch state {
      case .setup, .waiting:
        self?.connectionState = .connecting
      case .ready:
        self?.connectionState = .connected
      case .failed:
        self?.connectionState = .failed
      case .cancelled:
        self?.connectionState = .cancelled
      @unknown default:
        return
      }
      if let connectionState = self?.connectionState {
        self?.delegate?.connectionStateChanged(connectionState)
      }
    })
    .run { [weak self] connection in
      self?.connection = connection
    }
  }

  func subscribeListener() async throws {
    logger.info("\(#function)")

    let browser = NetworkBrowser(
      for: .wifiAware(
        .connecting(to: .allPairedDevices, from: .presentationService)
      )
    )
    browser.onStateUpdate { [weak self] browser, state in
      self?.logger.info("publishListener listener \(browser.debugDescription) state \(String(describing: state))")
      switch state {
      case .setup, .waiting:
        self?.connectionState = .connecting
      case .ready:
        self?.connectionState = .connected
      case .failed(_):
        self?.connectionState = .failed
      case .cancelled:
        self?.connectionState = .cancelled
      @unknown default:
        return
      }
      if let connectionState = self?.connectionState {
        self?.delegate?.connectionStateChanged(connectionState)
      }
    }
    let endpoint = try await browser.run { [weak self] endpoints in
      self?.logger.info("subscribeListener run endpoints \(endpoints)")
      if let endpoint = endpoints.first {
        return .finish(endpoint)
      } else {
        return .continue
      }
    }
    try await configureConnection(to: endpoint)
  }

  private func configureConnection(to endpoint: WAEndpoint) async throws {
    logger.info("\(#function) endpoint \(endpoint.description)")
    let connection = NetworkConnection(
      to: endpoint,
      using: .parameters(
        {
          Coder(
            receiving: P2PEvent.self,
            sending: P2PEvent.self,
            using: NetworkJSONCoder()
          ) {
            UDP()
          }
        })
        .wifiAware { $0.performanceMode = .realtime }
        .serviceClass(appServiceClass)
    )
    self.connection = connection

    for try await (event, _) in connection.messages {
      logger.info("configureConnection received \(event)")
      self.receivedEvent = event
      self.delegate?.receivedEvent(event)
    }
  }

  func send(_ event: P2PEvent) async throws {
    logger.info("\(#function) event \(event)")
    guard let connection else {
      return
    }
    do {
      try await connection.send(event)
    } catch {
      logger.info("error \(error.localizedDescription)")
    }
  }
}
