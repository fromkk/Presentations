import SwiftUI
import MultipeerConnectivity

#if canImport(UIKit)
struct MultipeerBrowserView: UIViewControllerRepresentable {
  let connector: PresentationMultipeerConnector
  @Environment(\.dismiss) private var dismiss

  func makeUIViewController(context: Context) -> MCBrowserViewController {
    let controller = connector.makeBrowserViewController()
    controller.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(dismiss: dismiss)
  }

  final class Coordinator: NSObject, MCBrowserViewControllerDelegate {
    let dismiss: DismissAction
    init(dismiss: DismissAction) {
      self.dismiss = dismiss
    }

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
      dismiss()
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
      dismiss()
    }
  }
}
#elseif canImport(AppKit)
struct MultipeerBrowserView: NSViewControllerRepresentable {
  let connector: PresentationMultipeerConnector
  @Environment(\.dismiss) private var dismiss

  func makeNSViewController(context: Context) -> MCBrowserViewController {
    let controller = connector.makeBrowserViewController()
    controller.delegate = context.coordinator
    return controller
  }

  func updateNSViewController(_ nsViewController: MCBrowserViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(dismiss: dismiss)
  }

  final class Coordinator: NSObject, MCBrowserViewControllerDelegate {
    let dismiss: DismissAction
    init(dismiss: DismissAction) {
      self.dismiss = dismiss
    }

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
      dismiss()
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
      dismiss()
    }
  }
}
#endif

