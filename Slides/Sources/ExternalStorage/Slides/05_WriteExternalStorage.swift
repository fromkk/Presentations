import SlideKit
import SwiftUI

@Slide
struct WriteExternalStorageSlide: View {
  var body: some View {
    HeaderSlide("外部ストレージに書き込む") {
      Item("ImageCaptureCore.frameworkを利用して書き込み")
      Item("進捗やエラーを独自UIでハンドリング")
    }
  }
}

#Preview {
  SlidePreview {
    WriteExternalStorageSlide()
  }
}
