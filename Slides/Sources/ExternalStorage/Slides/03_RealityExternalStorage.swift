import SlideKit
import SwiftUI

@Slide
struct RealityExternalStorageSlide: View {
  var body: some View {
    HeaderSlide("外部ストレージの現実") {
      Item("iOSではUIDocumentPickerViewControllerが一般的")
      Item("接続タイミングを柔軟に扱うのは難しい")
      Item("他の選択肢を模索する必要がある")
    }
  }
}

#Preview {
  SlidePreview {
    RealityExternalStorageSlide()
  }
}
