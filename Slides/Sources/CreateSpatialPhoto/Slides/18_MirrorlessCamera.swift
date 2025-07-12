import SlideKit
import SwiftUI

@Slide
struct MirrorlessCameraSlide: View {
  var body: some View {
    Text("ミラーレスカメラを利用する")
          .font(.system(size: 96))
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
