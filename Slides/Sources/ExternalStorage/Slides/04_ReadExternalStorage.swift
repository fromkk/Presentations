import SlideKit
import SwiftUI

@Slide
struct ReadExternalStorageSlide: View {
  var body: some View {
    HeaderSlide("外部ストレージを読む") {
      Item("ImageCaptureCore.frameworkの紹介")
      Item("AVExternalStorageDeviceDiscoverySessionで接続を検出")
      Item("取得データを独自UIで表示")
    }
  }
}

#Preview {
  SlidePreview {
    ReadExternalStorageSlide()
  }
}
