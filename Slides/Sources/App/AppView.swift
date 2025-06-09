import AboutSkip
import Common
import Potatotips0527
import SlideKit
import SwiftUI
import SwiftUITransition
import MitumerundesuSpatialPhoto
import visionOSMeetupVol10

@Observable @MainActor
public final class PresentationStore {
  public init() {}
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
          store.currentSlideConfiguration = AboutSkipSlideConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(AboutSkipSlideConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }

        Button {
          store.currentSlideConfiguration = Potatotips0527SlideConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(Potatotips0527SlideConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }

        Button {
          store.currentSlideConfiguration = VisionOSMeetUpVol10Configuration()
          openWindows()
        } label: {
          HStack {
            Text(VisionOSMeetUpVol10Configuration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }

        Button {
          store.currentSlideConfiguration = SwiftUITransitionSlideConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(SwiftUITransitionSlideConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }

        Button {
          store.currentSlideConfiguration = MitumerundesuSpatialPhotoSlideConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(MitumerundesuSpatialPhotoSlideConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }
      }
      .navigationTitle(Text("Presentations"))
    }
  }
}
