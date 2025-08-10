import Common
import SlideKit
import SwiftUI

@Slide
struct SaveAPhotoToExternalStorage: View {
  let url: URL = URL(
    string: "https://developer.apple.com/documentation/avfoundation/avexternalstoragedevice")!

  var body: some View {
    HeaderSlide("撮影した画像を外部ストレージに保存する") {
      Item("AVFoundationにAVExternalStorageDeviceというものがある")
      Item("手元で確認したところiPhoneのみ対応していることに注意（iPadは未対応）")
      Item("\(url)") {
        BackportWebView(url: url)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    SaveAPhotoToExternalStorage()
  }
}
