import SlideKit
import SwiftUI

@Slide
struct AfterHostingSlide: View {
  var transition: AnyTransition = .push(from: .trailing)
  
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
