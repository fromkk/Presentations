import Common
import SlideKit
import SwiftUI

@Slide
struct SaveAPhotoToExternalStorage: View {
  let url: URL = URL(
    string: "https://developer.apple.com/documentation/avfoundation/avexternalstoragedevice")!

  var body: some View {
    HeaderSlide("撮影した画像を外部ストレージに保存する") {
      Item("UIDocumentPickerViewControllerや.fileExporterを利用するとユーザーに保存場所を選んでもらう必要がある")
      Item("AVFoundationにAVExternalStorageDeviceというものがある（iPhoneのみ対応）")
      Item("\(url)") {
        BackportWebView(url: url)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    撮影した画像を外部ストレージに保存するにはどうするといいでしょうか？
    パッと思いつくのはUIDocumentPickerViewControllerや.fileExporter modifierを利用することが多いと思いますが、これはユーザーに保存場所を選んでもらう必要があります。
    独自UIでUXを向上させるために色々調べていたところ、AVFoundationにAVExternalStorageDeviceというものがあるのを発見しました。
    注意事項としてはこのAPIは手元で見たところ、iPhoneでしか動かないことに注意が必要です。
    """
}

#Preview {
  SlidePreview {
    SaveAPhotoToExternalStorage()
  }
}
