import Common
import SlideKit
import SwiftUI

@Slide
struct SaveAPhotoToExternalStorage: View {
  var body: some View {
    HeaderSlide("撮影した画像を外部ストレージに保存する") {
      Item("パッと思いつくのはUIDocumentPickerViewControllerや.fileExporter modifier")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    撮影した画像を外部ストレージに保存するにはどうするといいでしょうか？
    パッと思いつくのはUIDocumentPickerViewControllerや.fileExporter modifierを利用することです。
    実際の動きを見てみましょう。
    """
}

#Preview {
  SlidePreview {
    SaveAPhotoToExternalStorage()
  }
}
