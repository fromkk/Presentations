import SlideKit
import SwiftUI

@Slide
struct MakingApproachSlide: View {
  var body: some View {
    HeaderSlide("作り方は分かった") {

    }
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
