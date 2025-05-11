import SlideKit
import SwiftUI

@Slide
struct QuestionSpatialPhotoSlide: View {
  var body: some View {
    Text("Have you ever taken a spatial photo? ✋")
      .font(.system(size: 80))
  }
}

#Preview {
  SlidePreview {
    QuestionSpatialPhotoSlide()
  }
}
