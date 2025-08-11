import AVFoundation
import SlideKit
import SwiftUI

@Slide
struct CheckAvailableSlide: View {
  @State var isSupported: Bool = AVExternalStorageDeviceDiscoverySession.isSupported

  var body: some View {
    HeaderSlide("AVExternalStorageDeviceが利用可能か確認する") {
      Item(
        "AVExternalStorageDeviceDiscoverySession.isSupported \(isSupported ? "true" : "false")"
      )
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    AVExternalStorageDeviceが利用可能か確認するにはAVExternalStorageDeviceDiscoverySession.isSupportedの値を確認します。
    手元で確認したところ、iPhoneでしかtrueになっていませんでした。
    """
}
