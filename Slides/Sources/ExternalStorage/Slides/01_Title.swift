import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    Text("独自UIで実現する外部ストレージデバイスの読み書き")
      .font(.system(size: 96, weight: .bold))
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
