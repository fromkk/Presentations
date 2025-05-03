import Interfaces
import Potatotips0527
import SlideKit
import SwiftUI

@Observable
final class PresentationStore {
  var currentSlideConfiguration: (any SlideConfigurationInterface)?
}

@main
struct PresentationsApp: App {
  @Bindable var store = PresentationStore()

  @Environment(\.openWindow) var openWindow

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        List {
          Button {
            store.currentSlideConfiguration = PotatotipsSlideConfiguration()
            openWindow(
              id: "presentation"
            )
            openWindow(
              id: "presenter"
            )
          } label: {
            HStack {
              Text("potatotips 05/27")
                .frame(maxWidth: .infinity, alignment: .leading)

              Image(systemName: "chevron.forward")
            }
            .padding()
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
          })
      }
    }

    WindowGroup(id: "presenter") {
      if let configuration = store.currentSlideConfiguration {
        macOSPresenterView(
          slideSize: configuration.size,
          slideIndexController: configuration.slideIndexController,
          content: {
            presentationContentView
          })
      }
    }
    .setupAsPresenterWindow()
  }

  @ViewBuilder
  var presentationContentView: some View {
    if let configuration = store.currentSlideConfiguration {
      SlideRouterView(slideIndexController: configuration.slideIndexController)
    } else {
      EmptyView()
    }
  }
}
