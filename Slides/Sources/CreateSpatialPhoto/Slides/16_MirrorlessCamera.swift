import SlideKit
import SwiftUI

@Slide
struct MirrorlessCameraSlide: View {
  var body: some View {
    HeaderSlide("ミラーレスカメラを利用する") {

    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    MirrorlessCameraSlide()
  }
}
