import SlideKit
import SwiftUI

@Slide
struct DoubleLensSlide: View {
  var body: some View {
    Text("レンズ2つにできないか？ 🤔")
          .font(.system(size: 96))
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
