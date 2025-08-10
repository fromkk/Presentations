import Common
import SlideKit
import SwiftUI

@Slide
struct OtherSlide: View {
  let icCameraDeviceURL = URL(string: "https://developer.apple.com/documentation/imagecapturecore/iccameradevice")!
  var body: some View {
    HeaderSlide("その他のAPI") {
      Item("他にもダウンロードとか削除とかできるのでドキュメントを眺めながらやりたいことを実現してください")
      BackportWebView(url: icCameraDeviceURL)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      Text(icCameraDeviceURL.absoluteString)
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    OtherSlide()
  }
}
