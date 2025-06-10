import SlideKit
import SwiftUI

@Slide
struct AboutSpatialPhoto2Slide: View {
  var body: some View {
    HeaderSlide("About Spatial Photo") {
      HStack(spacing: 32) {
        VStack(alignment: .leading) {
          Item("左右並んだカメラで撮影した写真を1つのHEICファイルとして格納したもの")
          Item("Apple Vision Proなど専用デバイスで表示すると、写真に映るコンテンツが目の前で浮かぶような体験を味わうことができる")
        }
        .frame(maxWidth: .infinity)

        VStack(spacing: 32) {
          Image(.spatialPhoto)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      }
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    AboutSpatialPhoto2Slide()
  }
}
