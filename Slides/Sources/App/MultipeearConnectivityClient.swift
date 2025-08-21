#if canImport(UIKit)

  import Foundation
  @preconcurrency import MultipeerConnectivity
  import OSLog
  import Observation
  import SwiftUI
  import UIKit

  @MainActor
  protocol MultipeerConnectivityClientDelegate: AnyObject {
    func receivedEvent(_ event: MultiPeerConnectivityClient.Event)
    func connectionStateChanged(_ connectedPeers: [MCPeerID])
  }

  @Observable
  final class MultiPeerConnectivityClient: NSObject, MCSessionDelegate,
    MCBrowserViewControllerDelegate,
    MCAdvertiserAssistantDelegate,
    MCNearbyServiceAdvertiserDelegate,
    @unchecked Sendable
  {
    weak var delegate: MultipeerConnectivityClientDelegate?

    struct Event: Codable {
      enum Name: String, Codable {
        case slideSelected
        case scriptChanged
        case indexChanged
        case backSlide
        case forwardSlide
        case finished
      }

      let eventName: Name
      let eventValue: String
    }

    private let logger = Logger(
      subsystem: Bundle.main.bundleIdentifier!,
      category: "MultiPeerConnectivityClient"
    )

    private let serviceType = "presentations"
    private let myPeerID: MCPeerID
    private(set) var mcSession: MCSession
    private var mcAdvertiserAssistant: MCAdvertiserAssistant
    private var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser

    var mcBrowser: MCBrowserViewController
    private(set) var error: (any Error)?
    var receivedEvent: Event?

    var isSyncing: Bool = false

    /// 保留中の招待情報を保持するプロパティ
    var pendingInvitation:
      (peerID: MCPeerID, handler: (Bool, MCSession?) -> Void)?

    @MainActor
    override init() {
      let deviceName = UIDevice.current.name
      let safeName = deviceName.isEmpty ? "Unknown Device" : deviceName
      myPeerID = MCPeerID(displayName: safeName)

      let mcSession = MCSession(
        peer: myPeerID,
        securityIdentity: nil,
        encryptionPreference: .required
      )

      mcAdvertiserAssistant = MCAdvertiserAssistant(
        serviceType: serviceType,
        discoveryInfo: nil,
        session: mcSession
      )

      let mcBrowser = MCBrowserViewController(
        serviceType: serviceType,
        session: mcSession
      )
      self.mcBrowser = mcBrowser

      self.mcSession = mcSession

      self.mcNearbyServiceAdvertiser = .init(
        peer: myPeerID,
        discoveryInfo: nil,
        serviceType: serviceType
      )

      super.init()

      mcSession.delegate = self
      mcAdvertiserAssistant.delegate = self
      self.mcNearbyServiceAdvertiser.delegate = self
    }

    private(set) var isAdvertising: Bool = false
    private(set) var connectedPeers: [MCPeerID] = []

    var currentPeerID: String {
      return myPeerID.displayName
    }

    @MainActor
    func startAdvertising() {
      logger.info("\(#function)")
      guard !isAdvertising else {
        logger.warning("Already advertising, skipping start")
        return
      }

      isAdvertising = true
      mcAdvertiserAssistant.start()
      mcNearbyServiceAdvertiser.startAdvertisingPeer()
      logger.info(
        "Successfully started advertising as '\(self.myPeerID.displayName)'"
      )
    }

    @MainActor
    func stopAdvertising() {
      logger.info("\(#function)")
      guard isAdvertising else {
        logger.warning("Not advertising, skipping stop")
        return
      }

      isAdvertising = false
      mcAdvertiserAssistant.stop()
      mcNearbyServiceAdvertiser.stopAdvertisingPeer()
      logger.info("Successfully stopped advertising")
    }

    @MainActor
    func startBrowsing() -> MCBrowserViewController {
      logger.info("\(#function)")
      mcBrowser.delegate = self
      return mcBrowser
    }

    func sendEvent(_ event: Event) {
      logger.info("\(#function) event \(event.eventName.rawValue)")
      guard !mcSession.connectedPeers.isEmpty,
        let data = try? JSONEncoder().encode(event)
      else { return }
      do {
        try mcSession.send(
          data,
          toPeers: mcSession.connectedPeers,
          with: .reliable
        )
      } catch {
        logger.error("\(#function) error \(error)")
        Task { @MainActor in
          self.error = error
        }
      }
    }

    /// 招待を承諾する
    func acceptInvitation() {
      Task { @MainActor in
        guard let invitation = self.pendingInvitation else { return }
        invitation.handler(true, mcSession)
        self.pendingInvitation = nil
      }
    }

    /// 招待を拒否する
    func declineInvitation() {
      Task { @MainActor in
        guard let invitation = pendingInvitation else { return }
        invitation.handler(false, nil)
        pendingInvitation = nil
      }
    }

    // MARK: - MCSessionDelegate

    func session(
      _ session: MCSession,
      peer peerID: MCPeerID,
      didChange state: MCSessionState
    ) {
      let stateString: String
      switch state {
      case .notConnected: stateString = "notConnected"
      case .connecting: stateString = "connecting"
      case .connected: stateString = "connected"
      @unknown default: stateString = "unknown"
      }
      logger.info("Peer '\(peerID.displayName)' didChangeState: \(stateString)")

      Task { @MainActor in
        let connectedPeers: [MCPeerID] = session.connectedPeers
        self.connectedPeers = connectedPeers
        delegate?.connectionStateChanged(connectedPeers)
      }
    }

    func session(
      _ session: MCSession,
      didReceive data: Data,
      fromPeer peerID: MCPeerID
    ) {
      logger.info(
        "Received data \(String(data: data, encoding: .utf8) ?? "invalid") from '\(peerID.displayName)'"
      )
      if let event = try? JSONDecoder().decode(Event.self, from: data) {
        Task { @MainActor in
          self.delegate?.receivedEvent(event)
        }
      }
    }

    func session(
      _ session: MCSession,
      didReceive stream: InputStream,
      withName streamName: String,
      fromPeer peerID: MCPeerID
    ) {
      logger.info(
        "Received stream '\(streamName)' from '\(peerID.displayName)'"
      )
    }

    func session(
      _ session: MCSession,
      didReceiveCertificate certificate: [Any]?,
      fromPeer peerID: MCPeerID,
      certificateHandler: @escaping (Bool) -> Void
    ) {
      logger.info(
        "Received certificate from '\(peerID.displayName)', certificate: \(certificate != nil ? "present" : "nil")"
      )
      certificateHandler(true)
    }

    func session(
      _ session: MCSession,
      didStartReceivingResourceWithName resourceName: String,
      fromPeer peerID: MCPeerID,
      with progress: Progress
    ) {
      logger.info(
        "Started receiving resource '\(resourceName)' from '\(peerID.displayName)'"
      )
      Task { @MainActor in
        isSyncing = !progress.isFinished
      }
    }

    func session(
      _ session: MCSession,
      didFinishReceivingResourceWithName resourceName: String,
      fromPeer peerID: MCPeerID,
      at localURL: URL?,
      withError error: (any Error)?
    ) {
      Task { @MainActor in
        isSyncing = false
      }
      if let error {
        logger.error(
          "Failed receiving resource '\(resourceName)' from '\(peerID.displayName)': \(error.localizedDescription)"
        )
      } else if let localURL {
        logger.info(
          "Finished receiving resource '\(resourceName)' from '\(peerID.displayName)' at \(localURL.absoluteString)"
        )
        //      delegate?.receivedResource(localURL)
      }
    }

    // MARK: - MCBrowserViewControllerDelegate

    func browserViewControllerDidFinish(
      _ browserViewController: MCBrowserViewController
    ) {
      logger.info("\(#function)")
      Task { @MainActor in
        browserViewController.dismiss(animated: true)
      }
    }

    func browserViewControllerWasCancelled(
      _ browserViewController: MCBrowserViewController
    ) {
      logger.info("\(#function)")
      Task { @MainActor in
        browserViewController.dismiss(animated: true)
      }
    }

    // MARK: - MCAdvertiserAssistantDelegate

    func advertiserAssistantWillPresentInvitation(
      _ advertiserAssistant: MCAdvertiserAssistant
    ) {
      logger.info("\(#function)")
    }

    func advertiserAssistantDidDismissInvitation(
      _ advertiserAssistant: MCAdvertiserAssistant
    ) {
      logger.info("\(#function)")
    }

    // MARK: -

    func advertiser(
      _ advertiser: MCNearbyServiceAdvertiser,
      didReceiveInvitationFromPeer peerID: MCPeerID,
      withContext context: Data?,
      invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
      logger.info("\(#function) from \(peerID.displayName)")
      self.pendingInvitation = (peerID: peerID, handler: invitationHandler)
      NotificationCenter.default.post(
        name: .init("PendingInvitation"),
        object: nil
      )
    }
  }

  struct MultipeerBrowserView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MCBrowserViewController
    let store: MultiPeerConnectivityClient

    func makeUIViewController(context: Context) -> MCBrowserViewController {
      store.startBrowsing()
    }

    func updateUIViewController(
      _ uiViewController: MCBrowserViewController,
      context: Context
    ) {
      // nop
    }
  }
#endif
