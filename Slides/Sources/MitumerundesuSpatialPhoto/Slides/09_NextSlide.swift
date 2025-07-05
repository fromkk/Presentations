import SlideKit
import SwiftUI

@Slide
struct NextSlide: View {
  var body: some View {
    Text("次は空間写真を作りたい")
      .font(.system(size: 96))
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    NextSlide()
  }
}
