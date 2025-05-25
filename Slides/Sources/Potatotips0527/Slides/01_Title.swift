import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack(spacing: 32) {
      Text("What a `spatial` day!")
        .font(.system(size: 128))

      Text("空間写真を分解してみた")
        .font(.system(size: 64))
    }
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
