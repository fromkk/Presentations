#if !os(visionOS)

  import AVFoundation
  import Photos
  import SlideKit
  import SwiftUI

  @MainActor
  @Observable
  final class AddPhotoLibraryStore {
    func requestCameraRollAccess() async -> Bool {
      switch PHPhotoLibrary.authorizationStatus(for: .addOnly) {
      case .authorized, .limited:
        return true
      case .notDetermined:
        let result =
          await PHPhotoLibrary
          .requestAuthorization(for: .addOnly)
        return result == .authorized || result == .limited
      case .denied, .restricted:
        return false
      @unknown default:
        return false
      }
    }

    func saveToCameraRoll(_ data: Data) async throws {
      try await PHPhotoLibrary.shared().performChanges { @Sendable in
        let creationRequest = PHAssetCreationRequest.forAsset()
        creationRequest.addResource(
          with: .photo,
          data: data,
          options: nil
        )
      }
      
    }
  }

  @Slide
  struct SaveTakenPhoto: View {
    @Bindable var store: ExternalStorageObservationStore
    @Bindable var addPhotoLibraryStore: AddPhotoLibraryStore = .init()

    @Phase var phase: SlidePhase
    @State var imageData: Data?
    @State var error: (any Error)?
    @State var deviceList: [AVExternalStorageDevice] = []
    @State var selectedDevice: AVExternalStorageDevice?

    init() {
      store = ExternalStorageObservationStore()
    }

    enum SlidePhase: Int, PhasedState {
      case initial
      case photoTaken
    }

    var body: some View {
      HeaderSlide("撮影した画像を保存する") {
        Text("nextAvailableURLs(withPathExtensions:) で保存先を指定する")

        switch phase {
        case .initial:
          CameraView(
            photoTaken: { data in
              imageData = data
              $phase.forward()
            },
            captureFailed: { error in
              self.error = error
            }
          )
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .photoTaken:
          HStack(alignment: .top, spacing: 32) {
            if let imageData, let uiImage = UIImage(data: imageData) {
              Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            }

            VStack {
              Text("保存先")
              if store.deviceList.isEmpty {
                Button {
                  Task { @MainActor in
                    guard await addPhotoLibraryStore.requestCameraRollAccess(),
                      let imageData
                    else {
                      return
                    }
                    try await addPhotoLibraryStore.saveToCameraRoll(imageData)
                  }
                } label: {
                  Text("カメラロールに保存")
                }
              } else {
                List {
                  ForEach(store.deviceList, id: \.uuid) { device in
                    Button {

                    } label: {
                      Text("\(device.displayName ?? "No Name") に保存")
                    }
                  }
                }
              }
            }
          }
        }
      }
      .onAppear {
        store.observeDeviceNames()
      }
      .onDisappear {
        store.cancel()
      }
    }

    func save(to device: AVExternalStorageDevice) {

    }

    var transition: AnyTransition = .push(from: .trailing)
  }

  #Preview {
    SlidePreview {
      SaveTakenPhoto()
    }
  }

#endif
