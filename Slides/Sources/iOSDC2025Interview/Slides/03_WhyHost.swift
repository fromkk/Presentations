import SlideKit
import SwiftUI

@Slide
struct WhyHostSlide: View {
  var transition: AnyTransition = .push(from: .trailing)
  
  var body: some View {
    Text("なぜ○○.swiftを開催しようと思ったか")
      .font(.system(size: 96))
      .multilineTextAlignment(.center)
  }
}

#Preview {
  SlidePreview {
    WhyHostSlide()
  }
}
