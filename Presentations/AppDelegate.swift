#if canImport(UIKit)
  import App
  import UIKit

  @main
  class AppDelegate: UIResponder, UIApplicationDelegate {
    let store = PresentationStore()

    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication
        .LaunchOptionsKey: Any]?
    ) -> Bool {
      return true
    }

    func application(
      _ application: UIApplication,
      configurationForConnecting connectingSceneSession: UISceneSession,
      options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
      if connectingSceneSession.role == .windowExternalDisplayNonInteractive {
        return UISceneConfiguration(
          name: "External Configuration",
          sessionRole: connectingSceneSession.role
        )
      } else {
        return UISceneConfiguration(
          name: "Default Configuration",
          sessionRole: connectingSceneSession.role
        )
      }
    }

    func application(
      _ application: UIApplication,
      didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
    }
  }
#endif
