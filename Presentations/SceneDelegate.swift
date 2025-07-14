#if canImport(UIKit)
  import UIKit
  import SwiftUI
  import App

  class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
      guard
        let windowScene = (scene as? UIWindowScene),
        let store = (UIApplication.shared.delegate as? AppDelegate)?.store
      else {
        return
      }

      let contentView = AppView(store: store)

      window = UIWindow(windowScene: windowScene)
      window?.rootViewController = UIHostingController(rootView: contentView)
      window?.makeKeyAndVisible()
    }
  }
#endif
