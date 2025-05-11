import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack(spacing: 32) {
      Text("What a `spatial` day!")
        .font(.system(size: 128))

      Text("Split the spatial photo")
        .font(.system(size: 64))
    }
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
