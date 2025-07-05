import Common
import SlideKit
import SwiftUI
import WebKit

@Slide
struct SampleCodeSlide: View {
  var body: some View {
    HeaderSlide("Sample Code") {
      VStack {
//        if #available(iOS 18.4, macOS 15.4, visionOS 2.4, *) {
//          WebView(url: URL(string: "https://developer.apple.com/documentation/imageio/writing-spatial-photos")!)
// .frame(maxWidth: .infinity, maxHeight: .infinity)
//        } else {
          BackportWebView(url: URL(string: "https://developer.apple.com/documentation/imageio/writing-spatial-photos")!)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }

        Text("https://developer.apple.com/documentation/imageio/writing-spatial-photos")
      }
    }
  }
}

#Preview {
  SlidePreview {
    SampleCodeSlide()
  }
}
