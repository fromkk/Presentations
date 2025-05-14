import SlideKit
import SwiftUI

@Slide
struct DeepDiveSpatialPhotoSlide: View {
  var body: some View {
    HeaderSlide("Deep Dive: Spatial Photos") {
      HStack {
        Spacer()

        VStack(alignment: .center) {
          Image(.spatialFileFormat)
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text("https://developer.apple.com/videos/play/wwdc2024/10166/")
        }

        Spacer()
      }
    }
  }
}

#Preview {
  SlidePreview {
    DeepDiveSpatialPhotoSlide()
  }
}
