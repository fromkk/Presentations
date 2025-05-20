import SlideKit
import SwiftUI

#if os(visionOS)
  import RealityKit
#endif

@Slide
struct TitleSlide: View {
  var body: some View {
    #if os(visionOS)
      RealityView { content, attachments in
        if let title = attachments.entity(for: "title") {
          title.position = [0, 0, 0.3]
          content.add(title)
        }
      } attachments: {
        Attachment(id: "title") {
          Text("visionOSでSwiftUIを利用する際のUX向上")
            .font(.system(size: 108))
            .shadow(radius: 10)
        }
      }
    #else
      Text("visionOSでSwiftUIを利用する際のUX向上")
        .font(.system(size: 108))
    #endif
  }
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
