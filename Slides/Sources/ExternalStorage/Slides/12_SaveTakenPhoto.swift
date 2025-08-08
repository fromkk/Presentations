#if !os(visionOS)

import AVFoundation
import SlideKit
import SwiftUI

@Slide
struct SaveTakenPhoto: View {
  @State var store: ExternalStorageObservationStore
  @State var addPhotoLibraryStore: AddPhotoLibraryStore = .init()
  @State var addExternalStorageStore: AddExternalStorageStore = .init()

  @Phase var phase: SlidePhase
  @State var imageData: Data?
  @State var error: (any Error)?
  @State var deviceList: [AVExternalStorageDevice] = []
  @State var selectedDevice: AVExternalStorageDevice?

  // アラート表示用のState
  @State var showAlert: Bool = false
  @State var alertTitle: String = ""
  @State var alertMessage: String = ""

  enum SlidePhase: Int, PhasedState {
    case initial
    case photoTaken
  }

  init() {
    store = ExternalStorageObservationStore()
  }

  var body: some View {
    HeaderSlide("撮影した写真を保存") {
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
        ScrollView {
          VStack(alignment: .leading, spacing: 32) {
            if let imageData, let uiImage = UIImage(data: imageData) {
              Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 320)
            }

            VStack(alignment: .leading, spacing: 16) {
              Text("保存先")
              if store.deviceList.isEmpty {
                Button {
                  Task { @MainActor in
                    guard
                      await addPhotoLibraryStore.requestCameraRollAccess(),
                      let imageData
                    else {
                      alertTitle = "エラー"
                      alertMessage = "カメラロールへのアクセス許可が必要です"
                      showAlert = true
                      return
                    }

                    do {
                      try await addPhotoLibraryStore.saveToCameraRoll(
                        imageData
                      )
                      alertTitle = "成功"
                      alertMessage = "カメラロールに画像を保存しました"
                      showAlert = true
                    } catch {
                      alertTitle = "エラー"
                      alertMessage =
                        "カメラロールへの保存に失敗しました: \(error.localizedDescription)"
                      showAlert = true
                    }
                  }
                } label: {
                  Text("カメラロールに保存")
                }
                .buttonStyle(.borderedProminent)

                Code(
                  """
                  let result = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
                  guard result == .authorized || result == .limited else { return }
                  try await PHPhotoLibrary.shared().performChanges { @Sendable in
                    let creationRequest = PHAssetCreationRequest.forAsset()
                    creationRequest.addResource(
                      with: .photo,
                      data: data,
                      options: nil
                    )
                  }
                  """
                )
              } else {
                ForEach(store.deviceList, id: \.uuid) { device in
                  Button {
                    guard let imageData else { return }
                    do {
                      try addExternalStorageStore
                        .saveToExternalStorage(imageData, to: device)
                      alertTitle = "成功"
                      alertMessage =
                        "\(device.displayName ?? "外部デバイス")に画像を保存しました"
                      showAlert = true
                    } catch {
                      alertTitle = "エラー"
                      alertMessage =
                        "外部デバイスへの保存に失敗しました: \(error.localizedDescription)"
                      showAlert = true
                    }
                  } label: {
                    Text("\(device.displayName ?? "No Name") に保存")
                      .frame(maxWidth: .infinity)
                  }
                  .buttonStyle(.bordered)
                }

                Code(
                  """
                  guard
                    let url = try device.nextAvailableURLs(withPathExtensions: ["jpg"]).first,
                    url.startAccessingSecurityScopedResource()
                  else {
                    return
                  }
                  defer {
                    url.stopAccessingSecurityScopedResource()
                  }
                  try imageData.write(to: url)
                  """
                )
              }
            }
          }
        }
      }
    }
    .alert(alertTitle, isPresented: $showAlert) {
      Button("OK") {
        showAlert = false
      }
    } message: {
      Text(alertMessage)
    }
    .onAppear {
      store.observeDeviceNames()
    }
    .onDisappear {
      store.cancel()
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#endif
