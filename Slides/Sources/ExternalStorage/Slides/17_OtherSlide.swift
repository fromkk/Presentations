import Common
import SlideKit
import SwiftUI

@Slide
struct OtherSlide: View {
  let icCameraDeviceURL = URL(
    string: "https://developer.apple.com/documentation/imagecapturecore/iccameradevice")!
  var body: some View {
    HeaderSlide("さらに詳しく") {
      Item("他にもダウンロードとか削除とかできるのでドキュメントを参考に")
      BackportWebView(url: icCameraDeviceURL)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      Text(icCameraDeviceURL.absoluteString)
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    紹介したのはほんの一例です。
    他にもダウンロードやファイルの削除などの操作が可能です。
    さらに詳しく知りたい方はドキュメントを見ながら動きを確認するのがいいと思います。
    """
}

#Preview {
  SlidePreview {
    OtherSlide()
  }
}
