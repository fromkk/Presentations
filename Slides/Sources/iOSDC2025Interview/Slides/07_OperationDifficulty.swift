import SlideKit
import SwiftUI

@Slide
struct OperationDifficultySlide: View {
  var transition: AnyTransition = .push(from: .trailing)

  var body: some View {
    Text("運営で苦労したこと")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    OperationDifficultySlide()
  }
}
