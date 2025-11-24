import Common
import SlideKit
import SwiftUI

@Slide
struct SampleCodeSlide: View {
  var body: some View {
    HeaderSlide("Sample Code") {
      BackportWebView(
        url: URL(
          string: "https://developer.apple.com/documentation/wifiaware/building-peer-to-peer-apps")!
      )
      Text("https://developer.apple.com/documentation/wifiaware/building-peer-to-peer-apps")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    Appleが公開してくれているサンプルコードがあるので、興味ある人は参考にしてください。
    """
}
