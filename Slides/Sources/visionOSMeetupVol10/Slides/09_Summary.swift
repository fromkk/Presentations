import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("まとめ") {
      Item("3D空間にSwiftUIのカスタムボタンを設置した際に、触れるのか不安になりました")
      Item("カスタムボタンを利用しない、もしくは、ボタンにhoverEffectなどを適切に設定することで回避は可能")
      Item("複雑な3Dオブジェクトを用意しなくてもvisionOS向けのアプリはリリースできる")
    }
  }
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
