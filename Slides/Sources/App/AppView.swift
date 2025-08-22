import AboutSkip
import Combine
import Common
import CreateSpatialPhoto
import ExternalStorage
import MultipeerConnectivity
import Potatotips0527
import SlideKit
import SwiftUI
import SwiftUITransition
import visionOSMeetupVol10

@Observable @MainActor
public final class PresentationStore {
  public init() {
    #if canImport(UIKit)
      multipeerClient = .init()
      multipeerClient.delegate = self
    #endif
  }

  #if canImport(UIKit)
    let multipeerClient: MultiPeerConnectivityClient
  #endif

  public var currentSlideConfiguration: (any SlideConfigurationInterface)? {
    didSet {
      #if canImport(UIKit)
        if let slideIndexController = currentSlideConfiguration?
          .slideIndexController
        {
          multipeerClient.sendEvent(
            .init(
              eventName: .scriptChanged,
              eventValue: slideIndexController.currentScript
            )
          )
          multipeerClient.sendEvent(
            .init(
              eventName: .indexChanged,
              eventValue: "\(slideIndexController.currentIndex)"
            )
          )

          slideIndexController.$currentScript.sink {
            [weak self] script in
            guard let self else { return }
            self.multipeerClient.sendEvent(
              .init(eventName: .scriptChanged, eventValue: script)
            )
          }
          .store(in: &cancellables)

          slideIndexController.$currentIndex.sink {
            [weak self] index in
            guard let self else { return }
            self.multipeerClient.sendEvent(
              .init(eventName: .indexChanged, eventValue: "\(index)")
            )
          }
          .store(in: &cancellables)
        }
      #endif
    }
  }
  public var hasExternalDisplay: Bool = false

  public enum ExternalDisplayMode {
    case external
    case mirroring
  }
  public var externalDisplayMode: ExternalDisplayMode = .external

  #if canImport(UIKit)
    private var cancellables: Set<AnyCancellable> = []

    var presenterSlideIndexController: SlideIndexController?

    var presenterCurrentScript: String = ""

    var presenterCurrentIndex: Int = 0
  #endif
}

#if canImport(UIKit)
  extension PresentationStore: MultipeerConnectivityClientDelegate {
    func receivedEvent(_ event: MultiPeerConnectivityClient.Event) {
      switch event.eventName {
      case .slideSelected:
        switch event.eventValue {
        case "external-storage":
          #if os(iOS)
            presenterSlideIndexController =
              ExternalStorageConfiguration().slideIndexController
          #else
            break
          #endif
        default:
          break
        }
      case .scriptChanged:
        presenterCurrentScript = event.eventValue
      case .indexChanged:
        let index = Int(event.eventValue) ?? 0
        presenterCurrentIndex = index
        presenterSlideIndexController?.move(to: index)
      case .backSlide:
        currentSlideConfiguration?.slideIndexController.back()
      case .forwardSlide:
        currentSlideConfiguration?.slideIndexController.forward()
      case .finished:
        presenterSlideIndexController = nil
      }
    }

    func connectionStateChanged(_ connectedPeers: [MCPeerID]) {

    }

    func backSlide() {
      multipeerClient.sendEvent(.init(eventName: .backSlide, eventValue: ""))
    }

    func forwardSlide() {
      multipeerClient.sendEvent(.init(eventName: .forwardSlide, eventValue: ""))
    }
  }
#endif

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
            }
          )
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

  #if canImport(UIKit)
    @State private var showingMultipeerBrowser = false
    @State private var showingInvitationAlert = false
    @State private var invitingPeerName = ""
    @State private var connectedPeersCount = 0
  #endif

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
          store.currentSlideConfiguration =
            SwiftUITransitionSlideConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(SwiftUITransitionSlideConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }

        Button {
          store.currentSlideConfiguration =
            CreateSpatialPhotoSlideConfiguration()
          openWindows()
        } label: {
          HStack {
            Text(CreateSpatialPhotoSlideConfiguration.title)
              .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.forward")
          }
        }

        #if os(iOS)
          Button {
            let configuration = ExternalStorageConfiguration()
            store.currentSlideConfiguration = configuration
            openWindows()
            store.multipeerClient.sendEvent(
              .init(eventName: .slideSelected, eventValue: configuration.id)
            )
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
      #if canImport(UIKit)
        .toolbar {
          ToolbarItem(placement: .primaryAction) {
            Button {
              showingMultipeerBrowser = true
            } label: {
              HStack(spacing: 4) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                if connectedPeersCount > 0 {
                  Text("\(connectedPeersCount)")
                  .font(.caption)
                  .foregroundColor(.primary)
                }
              }
            }
            .accessibilityLabel("接続 (\(connectedPeersCount)台)")
          }
        }
        .sheet(isPresented: $showingMultipeerBrowser) {
          MultipeerBrowserView(store: store.multipeerClient)
        }
        .onReceive(
          NotificationCenter.default.publisher(for: .init("PendingInvitation"))
        ) { _ in
          if let invitation = store.multipeerClient.pendingInvitation {
            invitingPeerName = invitation.peerID.displayName
            showingInvitationAlert = true
          }
        }
        .alert("接続招待", isPresented: $showingInvitationAlert) {
          Button("承諾") {
            store.multipeerClient.acceptInvitation()
          }
          Button("拒否", role: .cancel) {
            store.multipeerClient.declineInvitation()
          }
        } message: {
          Text("\(invitingPeerName)からの接続招待です")
        }
        .onAppear {
          store.multipeerClient.startAdvertising()
          connectedPeersCount = store.multipeerClient.connectedPeers.count
        }
        .onDisappear {
          store.multipeerClient.stopAdvertising()
        }
        .onChange(of: store.multipeerClient.connectedPeers) { _, newPeers in
          connectedPeersCount = newPeers.count
        }
      #endif
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
                    store.multipeerClient.sendEvent(
                      .init(eventName: .finished, eventValue: "")
                    )
                  }
                }
            )
          }
        }
      }
      .fullScreenCover(
        isPresented: Binding(
          get: {
            store.presenterSlideIndexController != nil
          },
          set: {
            if !$0 { store.presenterSlideIndexController = nil }
          }
        ),
        content: {
          if let slideIndexController = store.presenterSlideIndexController {
            NavigationStack {
              VStack {
                HStack {
                  PresentationView(
                    slideSize: SlideSize.standard16_9,
                    content: {
                      SlideRouterView(
                        slideIndexController: slideIndexController
                      )
                      .background(Color(uiColor: .systemBackground))
                    }
                  )
                  .frame(width: 480, height: 270)

                  ScrollView {
                    Text(store.presenterCurrentScript)
                      .font(.system(size: 36))
                      .foregroundColor(Color(uiColor: .label))
                      .multilineTextAlignment(.leading)
                      .lineLimit(nil)
                      .frame(maxWidth: .infinity, alignment: .leading)
                  }
                }

                HStack {
                  Spacer()

                  Button {
                    store.backSlide()
                  } label: {
                    Label("Back", systemImage: "chevron.backward")
                      .font(.system(size: 40))
                  }
                  .labelStyle(.iconOnly)

                  Text(
                    "\(store.presenterCurrentIndex + 1)/\(slideIndexController.slides.count)"
                  )

                  Button {
                    store.forwardSlide()
                  } label: {
                    Label("Forward", systemImage: "chevron.forward")
                      .font(.system(size: 40))
                  }
                  .labelStyle(.iconOnly)

                  Spacer()
                }
              }
              .background(Color(uiColor: .systemBackground))
              .toolbar {
                ToolbarItem(placement: .primaryAction) {
                  Button {
                    store.presenterSlideIndexController = nil
                  } label: {
                    Label("Close", systemImage: "xmark")
                  }
                }

                ToolbarItem(placement: .primaryAction) {
                  Button {
                    showingMultipeerBrowser = true
                  } label: {
                    HStack(spacing: 4) {
                      Image(systemName: "antenna.radiowaves.left.and.right")
                      if connectedPeersCount > 0 {
                        Text("\(connectedPeersCount)")
                          .font(.caption)
                          .foregroundColor(.primary)
                      }
                    }
                  }
                  .accessibilityLabel("接続 (\(connectedPeersCount)台)")
                }
              }
            }
            .gesture(
              DragGesture(minimumDistance: 100)
                .onEnded { value in
                  if value.translation.width < 100 {
                    store.forwardSlide()
                  } else if value.translation.width > -100 {
                    store.backSlide()
                  }
                }
            )
            .gesture(
              DragGesture(minimumDistance: 100)
                .onEnded { value in
                  if value.translation.height > 100 {
                    store.presenterSlideIndexController = nil
                  }
                }
            )
            .id(store.presenterCurrentScript)
          }
        }
      )
    #endif
  }
}
