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

  @ViewBuilder
  var presentationContentView: some View {
    if let configuration = store.currentSlideConfiguration {
      SlideRouterView(slideIndexController: configuration.slideIndexController)
        #if !os(visionOS)
          #if canImport(UIKit)
            .background(Color(uiColor: .systemBackground))
          #elseif canImport(AppKit)
            .background(Color(nsColor: .windowBackgroundColor))
          #endif
        #else
          .ornament(
            attachmentAnchor: .scene(.bottom),
            ornament: {
              HStack(spacing: 32) {
                Button {
                  configuration.slideIndexController.back()
                } label: {
                  Image(systemName: "chevron.backward")
                }
                .accessibilityLabel("Backward")

                Button {
                  configuration.slideIndexController.forward()
                } label: {
                  Image(systemName: "chevron.forward")
                }
                .accessibilityLabel("Forward")
              }
            })
        #endif
        .gesture(
          DragGesture(minimumDistance: 100)
            .onEnded { value in
              if value.translation.width < 100 {
                configuration.slideIndexController.forward()
              } else if value.translation.width > -100 {
                configuration.slideIndexController.back()
              }
            }
        )
    } else {
      EmptyView()
    }
  }

  var body: some Scene {
    WindowGroup {
      AppView(store: store)
    }

    WindowGroup(id: "presentation") {
      if let configuration = store.currentSlideConfiguration {
        PresentationView(
          slideSize: configuration.size,
          content: {
            presentationContentView
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
              presentationContentView
            }
          )
        }
      }
      .setupAsPresenterWindow()
    #endif
  }
}
