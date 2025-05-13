import SlideKit
import SwiftUI

#if canImport(RealityKit)
  import RealityKit
#endif

@Slide
struct TitleSlide: View {
  var body: some View {
    #if canImport(RealityKit)
      RealityView { content, attachments in
        if let title = attachments.entity(for: "title") {
          title.position = [0, 0, 0.3]
          content.add(title)
        }
      } attachments: {
        Attachment(id: "title") {
          Text("3D空間でSwiftUIを利用する際のUX向上")
            .font(.system(size: 108))
            .shadow(radius: 10)
        }
      }
    #else
      Text("3D空間でSwiftUIを利用する際のUX向上")
        .font(.system(size: 108))
    #endif
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
