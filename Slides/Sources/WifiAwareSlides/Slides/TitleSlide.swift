import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    Text("Wi-Fi Aware試してみた")
      .font(.system(size: 128).bold())
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
