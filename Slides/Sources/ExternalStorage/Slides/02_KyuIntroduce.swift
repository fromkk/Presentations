import SlideKit
import SwiftUI

@Slide
struct AboutKyuSlide: View {
  var body: some View {
    HeaderSlide("kyu の紹介") {

    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    AboutKyuSlide()
  }
}
