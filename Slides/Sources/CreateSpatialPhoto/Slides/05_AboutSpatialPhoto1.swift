import SlideKit
import SwiftUI

@Slide
struct AboutSpatialPhoto1Slide: View {
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      Image(.wwdc23)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .allowsHitTesting(false)

      HeaderSlide("About Spatial Photo") {
        Item("WWDC23")
        Item("https://developer.apple.com/videos/play/wwdc2023/101/")
        Item(
          "With the release of iOS 17.2, Apple enabled spatial video recording on iPhone 15 Pro and iPhone 15 Pro Max."
        )
      }
      .environment(\.colorScheme, .dark)
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    AboutSpatialPhoto1Slide()
  }
}
