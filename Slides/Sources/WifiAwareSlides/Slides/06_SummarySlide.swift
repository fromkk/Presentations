import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("Summary") {
      Item("最初自分で実装しようとしたけど、ハマってうまくいかなかった")
      Item("Appleのサンプルコードの一部を一旦そのまま持ってきてなんとか動く状態に")
      Item("何が悪かったのかはこれから")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    まとめです。
    Wi-Fi Awareについて調べて実装してみました。
    最初自分で実装しようとしたけど、ハマってうまくいかなかったのですが、一旦Appleのサンプルコードの一部をそのまま持ってきて最低限は動くようになりました。
    自分の実装で何が悪かったのかはこれから調べてみようと思います。

    以上です。ご清聴ありがとうございました。
    """
}
