import SlideKit
import SwiftUI

@Slide
struct ApproachMethodSlide: View {
  var body: some View {
    HeaderSlide("作るためのアプローチ方法") {
      Item("iPhoneを複数使う")
      Item("ミラーレスカメラを利用する")
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    ApproachMethodSlide()
  }
}
