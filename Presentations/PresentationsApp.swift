import AboutSkip
import Interfaces
import Potatotips0527
import SlideKit
import SwiftUI
import visionOSMeetupVol10

@Observable @MainActor
final class PresentationStore {
  var aboutConiguration: AboutSkipSlideConfiguration = .init()
  var potatotipsConfiguration: Potatotips0527SlideConfiguration = .init()
  var visionProMeetupVol10 = VisionOSMeetUpVol10Configuration()
  var currentSlideConfiguration: (any SlideConfigurationInterface)?
}

@main
struct PresentationsApp: App {
  @Bindable var store = PresentationStore()

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
    } else {
      EmptyView()
    }
  }

  @Environment(\.openWindow) var openWindow

  private func openWindows() {
    openWindow(id: "presentation")
    #if canImport(AppKit)
      openWindow(id: "presenter")
    #endif
  }

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        List {
          Button {
            store.currentSlideConfiguration = store.aboutConiguration
            openWindows()
          } label: {
            HStack {
              Text(store.aboutConiguration.title)
                .frame(maxWidth: .infinity, alignment: .leading)

              Image(systemName: "chevron.forward")
            }
          }

          Button {
            store.currentSlideConfiguration = store.potatotipsConfiguration
            openWindows()
          } label: {
            HStack {
              Text(store.potatotipsConfiguration.title)
                .frame(maxWidth: .infinity, alignment: .leading)

              Image(systemName: "chevron.forward")
            }
          }

          Button {
            store.currentSlideConfiguration = store.visionProMeetupVol10
            openWindows()
          } label: {
            HStack {
              Text(store.visionProMeetupVol10.title)
                .frame(maxWidth: .infinity, alignment: .leading)

              Image(systemName: "chevron.forward")
            }
          }
        }
        .navigationTitle(Text("Presentations"))
      }
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
