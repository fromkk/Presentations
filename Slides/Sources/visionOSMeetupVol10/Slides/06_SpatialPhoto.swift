import SlideKit
import SwiftUI

@Slide
struct SpatialPhotoSlide: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    HeaderSlide("おまけ") {
      ScrollView {
        Item("空間写真をアプリ内で表示したくなった")
          .frame(maxWidth: .infinity, alignment: .leading)
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
          """,
          colorTheme: colorScheme == .dark ? .defaultDark : .presentation,
          fontSize: 40
        )
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

#Preview {
  SlidePreview {
    SpatialPhotoSlide()
  }
}
