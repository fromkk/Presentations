#if canImport(UIKit)
  import App
  import SlideKit
  import UIKit
  import SwiftUI

final class ExternalSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
      guard
        let scene = scene as? UIWindowScene,
        let store = (UIApplication.shared.delegate as? AppDelegate)?.store
      else {
        return
      }

      let window = UIWindow(windowScene: scene)
      window.rootViewController = UIHostingController(
        rootView: ExternalView(store: store)
      )
      window.makeKeyAndVisible()
      self.window = window

      (UIApplication.shared.delegate as? AppDelegate)?.store
        .hasExternalDisplay = true
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      (UIApplication.shared.delegate as? AppDelegate)?.store
        .hasExternalDisplay = false
    }
  }

  struct ExternalView: View {
    @Bindable var store: PresentationStore

    var body: some View {
      if let currentSlideConfiguration = store.currentSlideConfiguration {
        PresentationView(
          slideSize: currentSlideConfiguration.size,
          content: { PresentationContentView(store: store) }
        )
      } else {
        Color.black
      }
    }
  }
#endif
