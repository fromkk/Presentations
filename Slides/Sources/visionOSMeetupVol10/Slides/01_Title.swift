import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    Text("3D空間でSwiftUIを利用する際のUX向上")
      .font(.system(size: 108))
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
