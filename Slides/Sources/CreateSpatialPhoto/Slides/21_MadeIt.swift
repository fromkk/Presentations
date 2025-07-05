import SlideKit
import SwiftUI

@Slide
struct MadeItSlide: View {
  var body: some View {
    HeaderSlide("作ってもらった") {

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
