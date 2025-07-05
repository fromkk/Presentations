import SlideKit
import SwiftUI

@Slide
struct MultipleiPhonesSlide: View {
  var body: some View {
    HeaderSlide("iPhoneを複数使う") {
      Item("何かしらの方法でシャッターを同時に押せないか")
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    MultipleiPhonesSlide()
  }
}
