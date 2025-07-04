import SlideKit
import SwiftUI

@Slide
struct NextEventSlide: View {
  var body: some View {
    Text("次回の開催について何か考えていることはあるか？")
      .font(.system(size: 96))
      .multilineTextAlignment(.center)
  }
}

#Preview {
  SlidePreview {
    NextEventSlide()
  }
}
