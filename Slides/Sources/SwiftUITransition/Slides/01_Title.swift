import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack {
      Text("SwiftUIのTransitionの世界")
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
