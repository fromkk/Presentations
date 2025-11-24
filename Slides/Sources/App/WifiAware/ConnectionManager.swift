import Foundation
import Network
import OSLog
import WiFiAware

typealias WiFiAwareConnection = NetworkConnection<Coder<P2PEvent, P2PEvent, NetworkJSONCoder>>
typealias WiFiAwareConnectionID = String
typealias WiFiAwareConnectionState = (WiFiAwareConnection, WiFiAwareConnection.State)

private struct ConnectionInfo {
  let receiverTask: Task<Void, Error>
  let stateUpdateTask: Task<Void, Error>
  var remoteDevice: WAPairedDevice?
}

enum LocalEvent: Sendable {
  case listenerRunning
  case listenerStopped(WiFiAwareError?)
  case browserRunning
  case browserStopped(WiFiAwareError?)
  case connecting
  case connection(ConnectionEvent)
}

enum ConnectionEvent: Sendable {
  case ready(WAPairedDevice, ConnectionDetail)
  case stopped(WAPairedDevice, WiFiAwareConnectionID, WiFiAwareError?)
  case performance(WAPairedDevice, ConnectionDetail)
}

struct ConnectionDetail: Sendable {
  let connection: WiFiAwareConnection
  let performanceReport: WAPerformanceReport?
}

actor ConnectionManager: Sendable {
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: "ConnectionManager"
  )

  private var connections: [WiFiAwareConnectionID: WiFiAwareConnection] = [:]
  private var connectionsInfo: [WiFiAwareConnectionID: ConnectionInfo] = [:]

  public let localEvents: AsyncStream<LocalEvent>
  private let localEventsContinuation: AsyncStream<LocalEvent>.Continuation

  public let networkEvents: AsyncStream<P2PEvent>
  private let networkEventsContinuation: AsyncStream<P2PEvent>.Continuation

  init() {
    (self.localEvents, self.localEventsContinuation) = AsyncStream.makeStream(of: LocalEvent.self)
    (self.networkEvents, self.networkEventsContinuation) = AsyncStream.makeStream(of: P2PEvent.self)
  }

  // MARK: - Setup

  func add(_ connection: WiFiAwareConnection) {
    logger.info("Add connection: \(connection.debugDescription)")

    connectionsInfo[connection.id] = .init(
      receiverTask: setupReceiver(connection),
      stateUpdateTask: setupStateUpdateHandler(connection))
  }

  func setupConnection(to endpoint: WAEndpoint) {
    let connection = NetworkConnection(
      to:
        endpoint,
      using: .parameters {
        Coder(receiving: P2PEvent.self, sending: P2PEvent.self, using: NetworkJSONCoder()) {
          UDP()
        }
      }
      .wifiAware { $0.performanceMode = appPerformanceMode }
      .serviceClass(appServiceClass)
    )

    logger.info("Set up connection: \(connection.debugDescription)\nto: \(endpoint)")

    add(connection)
  }

  // MARK: - State Updates

  private func setupStateUpdateHandler(_ connection: WiFiAwareConnection) -> Task<Void, Error> {
    let (stream, continuation) = AsyncStream.makeStream(of: WiFiAwareConnectionState.self)

    connection.onStateUpdate { connection, state in
      self.logger.info("\(connection.debugDescription): \(String(describing: state))")
      continuation.yield((connection, state))
    }

    return Task {
      for await (connection, state) in stream {
        var connectionError: NWError? = nil

        switch state {
        case .setup, .waiting, .preparing: break

        case .ready:
          connections[connection.id] = connection

          if let wifiAwarePath = try await connection.currentPath?.wifiAware {
            let connectedDevice = wifiAwarePath.endpoint.device
            let performanceReport = wifiAwarePath.performance

            let detail = ConnectionDetail(
              connection: connection, performanceReport: performanceReport)
            localEventsContinuation.yield(.connection(.ready(connectedDevice, detail)))

            connectionsInfo[connection.id]?.remoteDevice = connectedDevice
          }

        case .failed(let error):
          stop(connection)
          connectionError = error
          fallthrough

        case .cancelled:
          guard let disconnectedDevice = connectionsInfo[connection.id]?.remoteDevice else {
            continue
          }
          localEventsContinuation.yield(
            .connection(.stopped(disconnectedDevice, connection.id, connectionError?.wifiAware)))

        @unknown default: break
        }
      }
    }
  }

  // MARK: - Receive

  private func setupReceiver(_ connection: WiFiAwareConnection) -> Task<Void, Error> {
    logger.info("Set up receiver: \(connection.debugDescription)")

    return Task {
      for try await (event, _) in connection.messages {
        networkEventsContinuation.yield(event)
      }
    }
  }

  // MARK: - Send

  func send(_ event: P2PEvent, to connection: WiFiAwareConnection) async {
    do {
      try await connection.send(event)
    } catch {
      logger.error("Failed to send to: \(connection.debugDescription): \(error)")
    }
  }

  func sendToAll(_ event: P2PEvent) async {
    for connection in connections.values {
      await send(event, to: connection)
    }
  }

  // MARK: - Monitor

  func monitor() async throws {
    for connection in connections.values.filter({ $0.state == .ready }) {
      if let wifiAwarePath = try await connection.currentPath?.wifiAware {
        let device = wifiAwarePath.endpoint.device
        let performanceReport = wifiAwarePath.performance

        let detail = ConnectionDetail(connection: connection, performanceReport: performanceReport)
        localEventsContinuation.yield(.connection(.performance(device, detail)))
      }
    }
  }

  // MARK: - Teardown

  func stop(_ connection: WiFiAwareConnection) {
    logger.info("Stop connection: \(connection.debugDescription)")
    connectionsInfo[connection.id]?.receiverTask.cancel()
    if let removedConnection = connections.removeValue(forKey: connection.id) {
      logger.info("Removed: \(removedConnection.debugDescription)")
    }
  }

  func invalidate(_ id: WiFiAwareConnectionID) {
    logger.info("Invalidate connection ID: \(id)")
    connectionsInfo[id]?.stateUpdateTask.cancel()
    connectionsInfo.removeValue(forKey: id)
  }

  deinit {
    for info in connectionsInfo.values {
      info.receiverTask.cancel()
      info.stateUpdateTask.cancel()
    }
    connections.removeAll()

    localEventsContinuation.finish()
    networkEventsContinuation.finish()
  }
}
