import Common
import SlideKit
import SwiftUI

@Slide
struct ReferenceSlide: View {
  var body: some View {
    HeaderSlide("Reference") {
      BackportWebView(url: URL(string: "https://youtu.be/0HNH4Epbyfc?si=ZwFAc9Vc6lYrb_8Y&t=329")!)
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    今年のiOSDCでも @kuromelon257 さんが一部発表しています。
    興味のある方は是非ご覧ください。
    """
}

#Preview {
  SlidePreview {
    ReferenceSlide()
  }
}
