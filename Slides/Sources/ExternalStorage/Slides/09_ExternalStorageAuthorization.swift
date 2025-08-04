import AVFoundation
import SlideKit
import SwiftUI

@Slide
struct ExternalStorageAuthorization: View {
  @State var authorizationStatus: AVAuthorizationStatus
  @Environment(\.openURL) var openURL
  @Environment(\.scenePhase) var scenePhase

  init() {
    authorizationStatus = AVExternalStorageDevice.authorizationStatus
  }

  var body: some View {
    HeaderSlide("外部ストレージへのアクセスの許可") {
      HStack(alignment: .top) {
        Text("AVExternalStorageDevice.authorizationStatus = ")

        switch authorizationStatus {
        case .notDetermined:
          VStack(alignment: .leading) {
            Text(".notDetermined")

            Button {
              Task {
                _ = await AVExternalStorageDevice.requestAccess()
                authorizationStatus =
                  AVExternalStorageDevice.authorizationStatus
              }
            } label: {
              Text("AVExternalStorageDevice\n.requestAccess()")
            }
            .buttonStyle(.borderedProminent)
          }
        case .restricted:
          VStack(alignment: .leading) {
            Text(".restricted")
            OpenSettingsAppButton()
          }

        case .denied:
          VStack(alignment: .leading) {
            Text(".denied")
            OpenSettingsAppButton()
          }
        case .authorized:
          Text(".authorized")
        @unknown default:
          Text(".unknown")
        }
      }
    }
    .onChange(of: scenePhase) { oldValue, newValue in
      if newValue == .active {
        authorizationStatus = AVExternalStorageDevice.authorizationStatus
      }
    }
  }

  func OpenSettingsAppButton() -> some View {
    Button {
      openURL(URL(string: UIApplication.openSettingsURLString)!)
    } label: {
      Text("設定アプリを開く")
    }
    .buttonStyle(.borderedProminent)
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    ExternalStorageAuthorization()
  }
}
