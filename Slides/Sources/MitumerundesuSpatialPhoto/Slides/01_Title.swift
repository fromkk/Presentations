import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack {
      Text("MITUMERUNDESUで撮った写真を空間写真へ")
        .font(.system(size: 92))
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
