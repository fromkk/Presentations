import AboutSkip
import Common
import CreateSpatialPhoto
import ExternalStorage
import Potatotips0527
import SlideKit
import SwiftUI
import SwiftUITransition
import visionOSMeetupVol10

@Observable @MainActor
public final class PresentationStore {
  public init() {}
  public var currentSlideConfiguration: (any SlideConfigurationInterface)?
  public var hasExternalDisplay: Bool = false

  public enum ExternalDisplayMode {
    case external
    case mirroring
  }
  public var externalDisplayMode: ExternalDisplayMode = .external
}

public struct PresentationContentView: View {
  public init(store: PresentationStore) {
    self.store = store
  }

  @Bindable var store: PresentationStore

  public var body: some View {
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
        .onTapGesture(count: 2) {
          if store.hasExternalDisplay {
            if store.externalDisplayMode == .external {
              store.externalDisplayMode = .mirroring
            } else {
              store.externalDisplayMode = .external
            }
          }
        }
    } else {
      EmptyView()
    }
  }
}

public struct AppView: View {
  public init(store: PresentationStore) {
    self.store = store
  }

  @Bindable var store: PresentationStore

  @Environment(\.openWindow) var openWindow
  @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows

  @State private var showingFullScreenPresentation = false

  private func openWindows() {
    if supportsMultipleWindows {
      openWindow(id: "presentation")
      #if canImport(AppKit)
        openWindow(id: "presenter")
      #endif
    } else {
      showingFullScreenPresentation = true
    }
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
          store.currentSlideConfiguration = CreateSpatialPhotoSlideConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(CreateSpatialPhotoSlideConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }

        #if !os(visionOS)
        Button {
          store.currentSlideConfiguration = ExternalStorageConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(ExternalStorageConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }
        #endif
      }
      .navigationTitle(Text("Presentations"))
    }
    #if canImport(UIKit)
      .fullScreenCover(isPresented: $showingFullScreenPresentation) {
        if let configuration = store.currentSlideConfiguration {
          NavigationStack {
            PresentationView(
              slideSize: configuration.size,
              content: {
                PresentationContentView(store: store)
              }
            )
            .gesture(
              DragGesture(minimumDistance: 100)
                .onEnded { value in
                  if value.translation.height > 100 {
                    showingFullScreenPresentation = false
                    store.currentSlideConfiguration = nil
                  }
                }
            )
          }
        }
      }
    #endif
  }
}
