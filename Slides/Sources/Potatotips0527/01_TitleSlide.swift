import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack {
      Text("Hello world")
        .font(.system(size: 120, weight: .bold))
    }
  }

  var shouldHideIndex: Bool { true }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
