import SlideKit
import SwiftUI

@Slide
struct OtherRegionsSlide: View {
  var body: some View {
    Text("他の地域だとどこにいきたい？")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    OtherRegionsSlide()
  }
}
