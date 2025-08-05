#if !os(visionOS)

import AVFoundation
import Photos
import SlideKit
import SwiftUI

@Slide
struct SaveTakenPhoto: View {
  @Bindable var store: ExternalStorageObservationStore

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

  func saveToCameraRoll() {

  }

  func save(to device: AVExternalStorageDevice) {

  }
}

#Preview {
  SlidePreview {
    SaveTakenPhoto()
  }
}

#endif
