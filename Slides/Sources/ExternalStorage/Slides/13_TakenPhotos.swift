import SlideKit
import SwiftUI

@Slide
struct TakenPhotos: View {
  var body: some View {
    HeaderSlide("撮ったファイルを閲覧") {
      ScrollView {
        VStack(alignment: .leading) {
          Item("外部ストレージに保存されたファイルをどうやって閲覧するか") {
            Item("UIDocumentPickerViewControllerや.fileImporterを利用することはできるが、ユーザーに選んでもらう必要がある")
            Item("AVExternalStorageDevice周りのドキュメントを見ても該当の記述は無さそう")
            Item("ExternalAccessory.frameworkを利用するにはMFiの取得が必要")
            Item("DriverKitを使えばもしかしたら実装は可能かもしれないが実装コストが高い") {
              Text("https://developer.apple.com/forums/thread/758598")
            }
            Item("FileManager.default.mountedVolumeURLsはmacOS以外ではnilが返る")
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
    UIDocumentPickerViewControllerや.fileImporter modifierを利用すれば一応確認はできるが、書き込み時と同様にユーザーに選んでもらう必要がありました。
    ここではUX向上のためにシステムで選んだデバイスのファイルを表示したいと思っています。
    書き込み時に利用したAVExternalStorageDevice周りのドキュメントを見ても該当の記述は無さそうでした。
    ExternalAccessory.frameworkを利用するにはMFiの取得が必要だったのでここでの利用は諦めました。
    DriverKitを使えばもしかしたら実装は可能かもしれないが実装コストが高いというフォーラムの意見がありペンディングとしました。
    FileManager.default.mountedVolumeURLsというそれっぽいメソッドがあるのですが、これはmacOS以外ではnilが返るとドキュメントに明記されています。
    """
}

#Preview {
  SlidePreview {
    TakenPhotos()
  }
}
