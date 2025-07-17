import SlideKit
import SwiftUI

@Slide
struct MadeItSlide: View {
  var body: some View {
    HeaderSlide("作ってもらった") {
      Image("2TUMERUNDES", bundle: .module)
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    MadeItSlide()
  }
}
