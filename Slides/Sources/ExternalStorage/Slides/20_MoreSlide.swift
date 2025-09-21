import Common
import SlideKit
import SwiftUI

@Slide
struct MoreSlide: View {
  @Phase var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case second
  }

  var body: some View {
    HeaderSlide("外部ストレージを読み込むための他の選択肢") {
      Item("AVExternalStorageDevice周りのドキュメントを見ても該当の記述は無さそう ❌")
      Item("ExternalAccessory.frameworkを利用するにはMFiの取得が必要 ⚠️")
      Item("DriverKitを使えばもしかしたら実装は可能かもしれないが実装コストが高い 🥺") {
        Text("https://developer.apple.com/forums/thread/758598")
      }
      Item("FileManager.default.mountedVolumeURLsはmacOS以外ではnilが返る 💻")
      if phase == .second {
        Item("今回はImageCaptureCore.frameworkを利用 ⭕️")
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String {
    switch phase {
    case .initial:
      return """
        その他の検討した選択肢も挙げておきます。
        まず、書き込み時に利用したAVExternalStorageDevice周りのドキュメントを見ても外部ストレージの内容を取得するなどの記述は無さそうでした。
        ExternalAccessory.frameworkを利用するにはMFiの取得が必要だったのでここでの利用は諦めました。
        DriverKitを使えばもしかしたら実装は可能かもしれないが実装コストが高いというフォーラムの意見がありペンディングとしました。
        FileManager.default.mountedVolumeURLsというそれっぽいメソッドがあるのですが、これはmacOS以外ではnilが返るとドキュメントに明記されています。
        """
    case .second:
      return """
        ということで今回はImageCaptureCore.frameworkを利用しました。
        """
    }
  }
}

#Preview {
  SlidePreview {
    MoreSlide()
  }
}
