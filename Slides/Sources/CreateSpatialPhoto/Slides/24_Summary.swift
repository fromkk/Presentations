import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("まとめ") {
      Item("空間写真を作る方法を調べてみた")
      Item("iPhone 2台を使って作ってみた")
      Item("ミラーレスカメラで作れないか模索してみた")
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
