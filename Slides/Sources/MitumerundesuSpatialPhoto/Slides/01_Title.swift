import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack {
      Text("MITUMERUNDESUで撮った写真を空間写真へ")
        .font(.system(size: 108))
    }
  }

  var shouldHideIndex: Bool { true }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
