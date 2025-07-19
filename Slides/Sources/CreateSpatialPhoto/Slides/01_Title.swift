import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack {
      Text("あなたの知らない空間写真の世界")
        .font(.system(size: 120, weight: .bold))
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
