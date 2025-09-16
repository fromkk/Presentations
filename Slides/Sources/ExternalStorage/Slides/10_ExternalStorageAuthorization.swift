import AVFoundation
import OSLog
import SlideKit
import SwiftUI

#if !os(visionOS)
  @Slide
  struct ExternalStorageAuthorization: View {
    @State var authorizationStatus: AVAuthorizationStatus
    @Environment(\.openURL) var openURL
    @Environment(\.scenePhase) var scenePhase
    let logger = Logger(
      subsystem: Bundle.main.bundleIdentifier!,
      category: "ExternalStorageAuthorization"
    )

    @Environment(\.colorScheme) var colorScheme

    init() {
      authorizationStatus = AVExternalStorageDevice.authorizationStatus
    }

    var body: some View {
      HeaderSlide("外部ストレージへのアクセスの許可") {
        Code(
          """
          /// ユーザーにアクセスの許可を求める
          AVExternalStorageDevice.requestAccess()
          """,
          syntaxHighlighter: colorScheme == .dark
            ? .presentationDark : .presentation
        )
        HStack(alignment: .top) {
          Text("AVExternalStorageDevice.authorizationStatus = ")

          switch authorizationStatus {
          case .notDetermined:
            VStack(alignment: .leading) {
              Text(".notDetermined")

              Button {
                requestAccess()
              } label: {
                Text("AVExternalStorageDevice\n.requestAccess()")
                  .padding()
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

    func requestAccess() {
      Task {
        let result = await AVExternalStorageDevice.requestAccess()
        logger.info("AVExternalStorageDevice.requestAccess() \(result)")
        authorizationStatus = AVExternalStorageDevice.authorizationStatus
      }
    }

    func OpenSettingsAppButton() -> some View {
      Button {
        #if canImport(UIKit)
          openURL(URL(string: UIApplication.openSettingsURLString)!)
        #endif
      } label: {
        Text("設定アプリを開く")
          .padding()
      }
      .buttonStyle(.borderedProminent)
    }

    var transition: AnyTransition = .push(from: .trailing)

    var script: String = """
      AVFoundationのAVExternalStorageDeviceを利用するためには、AVExternalStorageDeviceのrequestAccessメソッドからユーザーに利用の許諾を得る必要があります。
      許諾のステータスはauthorizationStatusから確認できます。
      """
  }

  #Preview {
    SlidePreview {
      ExternalStorageAuthorization()
    }
  }
#endif
