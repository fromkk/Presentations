import SlideKit
import SwiftUI

@Slide
struct DoubleLensSlide: View {
  var body: some View {
    HeaderSlide("レンズ2つにできないか？") {

    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    DoubleLensSlide()
  }
}
