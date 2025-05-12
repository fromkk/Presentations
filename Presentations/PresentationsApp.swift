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
        .background(.white)
        .foregroundColor(.black)
    } else {
      EmptyView()
    }
  }

  @Environment(\.openWindow) var openWindow

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        List {
          Button {
            store.currentSlideConfiguration = store.aboutConiguration
          } label: {
            HStack {
              Text(store.aboutConiguration.title)
                .frame(maxWidth: .infinity, alignment: .leading)

              Image(systemName: "chevron.forward")
            }
          }

          Button {
            store.currentSlideConfiguration = store.potatotipsConfiguration
          } label: {
            HStack {
              Text(store.potatotipsConfiguration.title)
                .frame(maxWidth: .infinity, alignment: .leading)

              Image(systemName: "chevron.forward")
            }
          }

          Button {
            store.currentSlideConfiguration = store.visionProMeetupVol10
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
      #if os(iOS)
        .fullScreenCover(
          isPresented: Binding(
            get: { store.currentSlideConfiguration != nil },
            set: { if !$0 { store.currentSlideConfiguration = nil } }
          ),
          content: {
            ZStack(alignment: .topTrailing) {
              if let configuration = store.currentSlideConfiguration {
                PresentationView(
                  slideSize: configuration.size,
                  content: {
                    presentationContentView
                  }
                )
              }

              Button {
                store.currentSlideConfiguration = nil
              } label: {
                Image(systemName: "xmark")
                  .padding(8)
                  .clipShape(Circle())
                  .overlay {
                    Circle()
                      .stroke(Color.accentColor, style: .init(lineWidth: 1))
                  }
              }
              .tint(Color.accentColor)
              .accessibilityLabel(Text("Close"))
              .padding()
            }
          })
      #endif
    }

    #if os(macOS)
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
