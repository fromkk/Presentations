import SlideKit
import SwiftUI

@Slide
struct DemoSlide: View {
  var body: some View {
    Text("Demo")
      .font(.system(size: 120, weight: .bold))
  }
}

#Preview {
  SlidePreview {
    DemoSlide()
  }
}
