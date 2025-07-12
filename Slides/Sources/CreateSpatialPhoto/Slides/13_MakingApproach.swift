import SlideKit
import SwiftUI

@Slide
struct MakingApproachSlide: View {
  var body: some View {
    Text("作り方は分かった")
      .font(.system(size: 96))
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    MakingApproachSlide()
  }
}
