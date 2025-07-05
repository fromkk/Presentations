import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack {
      Text("空間写真を作りたい！")
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
