import SlideKit
import SwiftUI

@Slide
struct BeforeSlide: View {
  var body: some View {
    HeaderSlide("potatotips") {
      Image(.potatotips)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

#Preview {
  SlidePreview {
    BeforeSlide()
  }
}
