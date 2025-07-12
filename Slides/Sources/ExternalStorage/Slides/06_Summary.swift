import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("まとめ") {
      Item("UIDocumentPickerViewController以外の方法を紹介")
      Item("ImageCaptureCore.frameworkで独自UIを構築")
      Item("外部ストレージとのデータやり取りを自由に")
    }
  }
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
