import AVKit
import SlideKit
import SwiftUI

@Slide
struct DemoSlide: View {
  var body: some View {
    HeaderSlide("Demo") {
      VideoPlayer(
        player: AVPlayer(
          url: Bundle.module.url(
            forResource: "SyncCamera",
            withExtension: "mov"
          )!
        )
      )
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    DemoSlide()
  }
}
