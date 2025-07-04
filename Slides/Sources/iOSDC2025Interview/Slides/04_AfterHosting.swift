import SlideKit
import SwiftUI

@Slide
struct AfterHostingSlide: View {
  var body: some View {
    Text("開催してどうだったか")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    AfterHostingSlide()
  }
}
