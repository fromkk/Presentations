import Foundation
import MultipeerConnectivity
import Observation

@Observable
final class PresentationMultipeerConnector: NSObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate {
  @ObservationIgnored private let serviceType = "prs-control"
  @ObservationIgnored private let peerID = MCPeerID(displayName: UIDevice.current.name)
  @ObservationIgnored private lazy var session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
  @ObservationIgnored private lazy var advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)

  override init() {
    super.init()
    session.delegate = self
    advertiser.delegate = self
    advertiser.startAdvertisingPeer()
  }

  func sendSlideConfigurationID(_ id: String) {
    guard !session.connectedPeers.isEmpty else { return }
    guard let data = id.data(using: .utf8) else { return }
    do {
      try session.send(data, toPeers: session.connectedPeers, with: .reliable)
    } catch {
      print("Failed to send slide ID: \(error)")
    }
  }

  // MARK: - MCSessionDelegate

  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {}

  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {}

  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}

  func session(
    _ session: MCSession,
    didStartReceivingResourceWithName resourceName: String,
    fromPeer peerID: MCPeerID,
    with progress: Progress
  ) {}

  func session(
    _ session: MCSession,
    didFinishReceivingResourceWithName resourceName: String,
    fromPeer peerID: MCPeerID,
    at localURL: URL?,
    withError error: Error?
  ) {}

  // MARK: - MCNearbyServiceAdvertiserDelegate

  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {}

  func advertiser(
    _ advertiser: MCNearbyServiceAdvertiser,
    didReceiveInvitationFromPeer peerID: MCPeerID,
    withContext context: Data?,
    invitationHandler: @escaping (Bool, MCSession?) -> Void
  ) {
    invitationHandler(true, session)
  }
}
