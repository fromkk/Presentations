import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    Text("独自UIで実現する\n外部ストレージデバイスの読み書き")
      .font(.system(size: 96, weight: .bold))
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    「独自UIで実現する外部ストレージデバイスの読み書き」というタイトルで発表します。よろしくお願いします。
    """
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
