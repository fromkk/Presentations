import SlideKit
import SwiftUI

@Slide
struct InterestingSlide: View {
  var body: some View {
    Text("漠然と何か面白いことができないか")
      .font(.system(size: 96))
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    InterestingSlide()
  }
}
