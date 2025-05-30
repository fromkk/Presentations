import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  var body: some View {
    HeaderSlide("まとめ") {
      Item("3D空間にSwiftUIのカスタムボタンを設置した際に、触れるのか不安になりました")
      Item("カスタムボタンを利用しない、もしくは、ボタンにhoverEffectなどを適切に設定することで回避は可能")
      Item("複雑な3Dオブジェクトを用意しなくてもvisionOS向けのアプリがリリースできました")
      Item("空間写真はデータさえあれば表示するのは簡単")
      Spacer()

      Text(
        "このスライドは https://github.com/mtj0928/SlideKit をforkしてvisionOSに対応させて作成しました（ https://github.com/fromkk/SlideKit ）"
      )
      Text("資料置き場 https://github.com/fromkk/Presentations")
    }
  }
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
