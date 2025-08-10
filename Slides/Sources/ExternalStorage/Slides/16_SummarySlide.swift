import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("Summary") {
      Item("AVExternalStorageDeviceを利用すればメディアの書き出しが可能に")
      Item("ImageCaptureCore.frameworkを利用すればメディアの読み込み・削除が可能に")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}
