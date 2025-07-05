import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("まとめ") {

    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
