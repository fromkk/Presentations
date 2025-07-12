import Common
import SlideKit
import SwiftUI

@Slide
struct CanUseMitumerundesSlide: View {
  var body: some View {
    HeaderSlide("MITUMERUNDESとか使えない？") {
      BackportWebView(url: URL(string: "https://note.com/takuma3_/n/n7586154de520")!)
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
