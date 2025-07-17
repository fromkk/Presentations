import Common
import SlideKit
import SwiftUI

@Slide
struct BeforeSlide: View {
  var body: some View {
    HeaderSlide("potatotips") {
      VStack {
        BackportWebView(url: URL(string: "https://note.com/fromkk/n/n545a852c26f2")!)
        Text("https://note.com/fromkk/n/n545a852c26f2")
      }
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    BeforeSlide()
  }
}
