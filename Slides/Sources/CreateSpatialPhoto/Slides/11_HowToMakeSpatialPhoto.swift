import SlideKit
import SwiftUI

/*
 空間写真を作るというスライドを作りたいです。
 まずは構成を考えたいと思っています。
 考えているのは

 - 空間写真の仕組み
 - 空間写真を作る方法
   - https://developer.apple.com/documentation/imageio/writing-spatial-photos を参考に
   - 注意点としては左右の画像のサイズが等しい必要がある
 - 面白い画像を作ってみたい
          - Create Spatial Photo の紹介
  - 2TUMERUNDESがあればできそう？
  - 結果
 - まとめ

 */

@Slide
struct HowToMakeSpatialPhoto: View {
  var body: some View {
    HeaderSlide("空間写真を作る方法") {
      Item("簡単に解説すると") {
        Item("`CGImageDestinationCreateWithURL` を作成し")
        Item("左右それぞれの画像を `CGImageDestinationAddImageFromSource` で追加")
        Item("`CGImageDestinationFinalize` で完成")
        Item(
          "`kCGImagePropertyGroups.kCGImagePropertyGroupType = kCGImagePropertyGroupTypeStereoPair` で作る必要がある"
        )
      }
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    HowToMakeSpatialPhoto()
  }
}
