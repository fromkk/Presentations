import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    Text("独自UIで実現する\n外部ストレージデバイスの読み書き")
      .font(.system(size: 96, weight: .bold))
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
