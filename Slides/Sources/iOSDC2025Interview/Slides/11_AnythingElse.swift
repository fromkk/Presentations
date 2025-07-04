import SlideKit
import SwiftUI

@Slide
struct AnythingElseSlide: View {
  var body: some View {
    Text("他に言いたいことあれば")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    AnythingElseSlide()
  }
}
