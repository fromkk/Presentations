import SlideKit
import SwiftUI

@Slide
struct CanUseMitumerundesSlide: View {
  var body: some View {
    HeaderSlide("MITUMERUNDESとか使えない？") {

    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    CanUseMitumerundesSlide()
  }
}
