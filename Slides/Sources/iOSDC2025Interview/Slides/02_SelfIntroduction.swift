import SlideKit
import SwiftUI

@Slide
struct SelfIntroductionSlide: View {
  var body: some View {
    Text("自己紹介")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    SelfIntroductionSlide()
  }
}
