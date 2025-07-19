import Common
import SlideKit
import SwiftUI

@Slide
struct CanUseMitumerundesSlide: View {
  let url = URL(string: "https://note.com/takuma3_/n/n7586154de520")!
  var body: some View {
    HeaderSlide("MITUMERUNDESとか使えない？") {
      VStack {
        BackportWebView(url: url)
        Text(url.absoluteString)
      }
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    CanUseMitumerundesSlide()
  }
}
