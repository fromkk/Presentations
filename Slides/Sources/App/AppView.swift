import AboutSkip
import Common
import Potatotips0527
import SlideKit
import SwiftUI
import visionOSMeetupVol10

@Observable @MainActor
public final class PresentationStore {
  public init() {}
  var aboutConiguration: AboutSkipSlideConfiguration = .init()
  var potatotipsConfiguration: Potatotips0527SlideConfiguration = .init()
  var visionProMeetupVol10 = VisionOSMeetUpVol10Configuration()
  public var currentSlideConfiguration: (any SlideConfigurationInterface)?
}

public struct AppView: View {
  public init(store: PresentationStore) {
    self.store = store
  }

  @Bindable var store: PresentationStore

  @Environment(\.openWindow) var openWindow

  private func openWindows() {
    openWindow(id: "presentation")
    #if canImport(AppKit)
      openWindow(id: "presenter")
    #endif
  }

  public var body: some View {
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
}
