import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("まとめ") {
      Item("iPhoneをカメラにするために撮影したデータを外部ストレージに記録・閲覧できるように")
      Item("AVExternalStorageDeviceを利用すればメディアの書き出しが可能に")
      Item("ImageCaptureCore.frameworkを利用すればメディアの読み込み・削除が可能に")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    まとめです。
    iPhoneをカメラにするために撮影したデータを外部ストレージに記録・閲覧できるようにしてみました。
    AVExternalStorageDeviceを利用すればメディアの書き出しができることが分かりました。
    ImageCaptureCore.frameworkを利用すればメディアの読み込み・削除が可能なことが分かりました。
    今後の開発においてこのトークが少しでも参考になれば幸いです。
    """
}
