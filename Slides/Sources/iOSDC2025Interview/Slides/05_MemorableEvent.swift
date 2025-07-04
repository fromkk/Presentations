import SlideKit
import SwiftUI

@Slide
struct MemorableEventSlide: View {
  var body: some View {
    Text("印象に残っている出来事は？")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    MemorableEventSlide()
  }
}
