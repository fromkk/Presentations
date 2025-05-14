import SlideKit
import SwiftUI

@Slide
struct VisionOSSlide: View {
  var body: some View {
    HeaderSlide("visionOSで空間写真を表示するには") {
      ScrollView {
        Code(
          """
          final public class PreviewApplication {
            /// Previews the provided URLs.
            ///
            /// This method launches the preview application with the provided URLs and, optionally, a selected URL.
            ///
            /// - Parameters:
            ///   - urls: An array of URLs to present in the new `PreviewApplication` scene.
            ///   - selectedURL: If provided and in the array of passed URLs, the URL to select in the presented collection..
            ///
            /// - Returns: A `PreviewSession` instance.
            ///
            final public class func open(urls: [URL], selectedURL: URL? = nil) -> PreviewSession

            /// Previews the provided items.
            ///
            /// This method launches the preview application with the provided preview items and, optionally, a selected item.
            ///
            /// - Parameters:
            ///   - items: An array of preview items to present in the new `PreviewApplication` scene.
            ///   - selectedItem: If provided and in the array of passed items, the preview item to select in the presented collection..
            ///
            /// - Returns: A `PreviewSession` instance.
            ///
            final public class func open(items: [PreviewItem], selectedItem: PreviewItem? = nil) -> PreviewSession
          }
          """
        )
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

#Preview {
  SlidePreview {
    VisionOSSlide()
  }
}
