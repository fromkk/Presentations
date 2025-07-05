import SlideKit
import SwiftUI

@Slide
struct MessageForHostsSlide: View {
  var transition: AnyTransition = .push(from: .trailing)
  
  var body: some View {
    Text("これから開催を考えている人に一言")
      .font(.system(size: 96))
  }
}

#Preview {
  SlidePreview {
    MessageForHostsSlide()
  }
}
