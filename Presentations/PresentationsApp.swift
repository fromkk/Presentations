import App
import SlideKit
import SwiftUI

#if canImport(UIKit)
  import UIKit
#elseif canImport(AppKit)
  import AppKit
#endif

@main
struct PresentationsApp: App {
  var store: PresentationStore = .init()

  var body: some Scene {
    WindowGroup {
      AppView(store: store)
    }

    WindowGroup(id: "presentation") {
      if let configuration = store.currentSlideConfiguration {
        PresentationView(
          slideSize: configuration.size,
          content: {
            PresentationContentView(store: store)
          }
        )
      }
    }

    #if canImport(AppKit)
      WindowGroup(id: "presenter") {
        if let configuration = store.currentSlideConfiguration {
          macOSPresenterView(
            slideSize: configuration.size,
            slideIndexController: configuration.slideIndexController,
            content: {
              PresentationContentView(store: store)
            }
          )
        }
      }
      .setupAsPresenterWindow()
    #endif
  }
}
