import SlideKit
import SwiftUI

@Slide
struct RegionalFlavorSlide: View {
  var transition: AnyTransition = .push(from: .trailing)
  
  var body: some View {
    Text(""地域らしさ" を出す工夫")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    RegionalFlavorSlide()
  }
}
