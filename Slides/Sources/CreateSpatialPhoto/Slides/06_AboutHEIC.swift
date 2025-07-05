import SlideKit
import SwiftUI

@Slide
struct AboutHEIC: View {
  var body: some View {
    HeaderSlide("About HEIF(HEIC / HEVC format)") {
      ScrollView {
        Item(
          "HEIF（ISO/IEC 23008-12）は、ISOベースメディアファイルフォーマット（ISOBMFF）に準拠したコンテナ形式で、HEVC（High Efficiency Video Coding）による高効率な画像・画像シーケンスの保存を目的"
        )

        Item("静止画、バースト写真、アニメーション（シネマグラフ）、焦点・露出スタックなど、幅広い画像用途を単一ファイルでサポート")

        Item("他の画像フォーマットと比較して拡張性と包括性が非常に高く、元の画像を保持したまま変換する非破壊編集（派生画像の定義）に対応")

        Item(
          "静止画は「アイテム」、画像シーケンスは「トラック」として格納され、ファイル内の複数の画像には「カバー画像」「サムネイル画像」「マスター画像」「補助画像」「派生画像」といった特定の役割を割り当てることが可能"
        )

        Item("HEVCイントラコーディングにより、同等の客観的画質でJPEGと比較して平均139%（約2.4倍）高いビットレート削減")

        Text("https://nokiatech.github.io/heif/technical.html")
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    AboutHEIC()
  }
}
