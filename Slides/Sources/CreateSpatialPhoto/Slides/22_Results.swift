import SlideKit
import SwiftUI

@Slide
struct ResultsSlide: View {
  var body: some View {
    HeaderSlide("成果") {

    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    ResultsSlide()
  }
}
