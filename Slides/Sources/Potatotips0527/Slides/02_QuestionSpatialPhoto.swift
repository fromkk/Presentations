import SlideKit
import SwiftUI

@Slide
struct QuestionSpatialPhotoSlide: View {
  var body: some View {
    VStack(spacing: 32) {
      Text("Have you ever taken a spatial photo? ✋")
        .font(.system(size: 80))

      Text("空間写真撮ったことある人？ ✋")
        .font(.system(size: 40))
    }

  }
}

#Preview {
  SlidePreview {
    QuestionSpatialPhotoSlide()
  }
}
