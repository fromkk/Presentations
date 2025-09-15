import SlideKit
import SwiftUI

@Slide
struct TakenPhotos: View {
  var body: some View {
    HeaderSlide("撮ったファイルを閲覧する") {
      ScrollView {
        VStack(alignment: .leading) {
          Item("外部ストレージに保存されたファイルをどうやって閲覧するか") {
            Item("パッと思いつくのはUIDocumentPickerViewControllerや.fileImporter") {
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    ここまでで撮影した画像を保存することができました。
    それでは撮影した画像はどうやって確認すればいいでしょうか？
    パッと思いつくのは書き込み時と同様にUIDocumentPickerViewControllerや.fileImporter modifierでしょうか。
    """
}

#Preview {
  SlidePreview {
    TakenPhotos()
  }
}
