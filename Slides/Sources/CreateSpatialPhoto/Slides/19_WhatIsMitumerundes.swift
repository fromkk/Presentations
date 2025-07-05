import SlideKit
import SwiftUI

@Slide
struct WhatIsMitumerundesSlide: View {
  var body: some View {
    HeaderSlide("MITUMERUNDESって何？") {

    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    WhatIsMitumerundesSlide()
  }
}
