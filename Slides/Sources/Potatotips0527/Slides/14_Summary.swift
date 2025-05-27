import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("Summary") {
      Item("空間写真を取得できたことでvisionOS側で空間写真を閲覧できるように")
      Item("iOSでも空間写真を閲覧したかったので方法を調査してみた")
      Item("写真をそれぞれ重ねてみることで3Dっぽい表現をすることができた")
      Spacer()
      Text("資料置き場 https://github.com/fromkk/Presentations")
    }
  }
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
