import CoreImage
import Photos
import PhotosUI
import SlideKit
import SwiftUI

@Slide
struct SplitSpatialPhoto1Slide: View {
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    HeaderSlide("左右それぞれの写真を取得してみる") {
      ScrollView {
        Code(
          """
          /// CGImageSource の作成
          let src = CGImageSourceCreateWithData(self as CFData, nil)
          /// プロパティの取得
          let properties = CGImageSourceCopyProperties(src, nil)
            as? [CFString: Any]
          /// グループの取得
          let groups = properties[kCGImagePropertyGroups] as? [[CFString: Any]],
          /// Stereo Pairの取得
          let stereoPairGroup = groups.first(where: {
            $0[kCGImagePropertyGroupType] as? String
              == (kCGImagePropertyGroupTypeStereoPair as String)
          })
          /// 左右の画像のIndexを取得
          let leftIndex = stereoPairGroup[kCGImagePropertyGroupImageIndexLeft]
            as? Int
          let rightIndex = stereoPairGroup[kCGImagePropertyGroupImageIndexRight]
            as? Int
          /// 左右の画像を取得
          let left = CGImageSourceCreateImageAtIndex(src, leftIndex, nil)
          let right = CGImageSourceCreateImageAtIndex(src, rightIndex, nil)
          """,
          syntaxHighlighter: colorScheme == .dark ? .presentationDark(fontSize: 40) : .presentation(fontSize: 40)
        )
      }
    }
  }
}

#Preview {
  SlidePreview {
    SplitSpatialPhoto1Slide()
  }
}
