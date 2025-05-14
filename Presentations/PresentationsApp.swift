import App
import SlideKit
import SwiftUI

@main
struct PresentationsApp: App {
  var store: PresentationStore = .init()

  @ViewBuilder
  var presentationContentView: some View {
    if let configuration = store.currentSlideConfiguration {
      SlideRouterView(slideIndexController: configuration.slideIndexController)
        #if !os(visionOS)
          .background(Color.white)
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
          DragGesture()
            .onEnded { value in
              if value.translation.width < 0 {
                configuration.slideIndexController.forward()
              } else {
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
