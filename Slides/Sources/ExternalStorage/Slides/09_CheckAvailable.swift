#if os(iOS)

  import AVFoundation
  import SlideKit
  import SwiftUI

  @Slide
  struct CheckAvailableSlide: View {
    @State var isSupported: Bool = AVExternalStorageDeviceDiscoverySession
      .isSupported

    var body: some View {
      HeaderSlide("AVExternalStorageDeviceを利用してみる") {
        Item("AVExternalStorageDeviceが利用可能か確認する") {
          Item(
            "AVExternalStorageDeviceDiscoverySession.isSupported \(isSupported ? "true" : "false")"
          )
        }
      }
    }

    var transition: AnyTransition = .push(from: .trailing)

    var script: String = """
      AVExternalStorageDeviceを利用してみます。
      AVExternalStorageDeviceが利用可能か確認するにはAVExternalStorageDeviceDiscoverySession.isSupportedの値を確認します。
      手元で確認したところ、iPhoneでしかtrueになっていませんでした。
      """
  }
#endif
