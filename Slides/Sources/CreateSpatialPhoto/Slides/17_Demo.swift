import SlideKit
import SwiftUI

@Slide
struct DemoSlide: View {
  var body: some View {
    HeaderSlide("Demo") {
      // Demo content can be added here
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    DemoSlide()
  }
}
