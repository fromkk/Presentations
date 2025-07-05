import Common
import SlideKit
import SwiftUI

@Slide
struct TweetSlide: View {
  var body: some View {
    HeaderSlide("たまたま目に入ったポスト") {
      Image(.tweet)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    TweetSlide()
  }
}
