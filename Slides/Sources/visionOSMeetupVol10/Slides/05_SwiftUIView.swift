import SlideKit
import SwiftUI

#if os(visionOS)
  import RealityKit
#endif

@Slide
struct SwiftUIViewSlide: View {
  var body: some View {
    HeaderSlide("SwiftUIのViewを配置") {
      HStack {
        GeometryReader { proxy in
          VStack {
            Item("attachmentsを利用")
              .frame(maxWidth: .infinity, alignment: .leading)
            Code(
              """
              RealityView { content, attachments in
                if let text = attachments.entity(for: "text") {
                  text.position = [0, 0, 0.3]
                  content.add(text)
                }
              } attachments: {
                Attachment(id: "text") {
                  Text("Hello world")
                }
              }
              """, fontSize: 36)
          }
          .frame(maxWidth: proxy.size.width * 0.5)

          #if os(visionOS)
            RealityView { content, attachments in
              if let text = attachments.entity(for: "text") {
                text.position = [0.6, 0, 0.3]
                content.add(text)
              }
            } attachments: {
              Attachment(id: "text") {
                Text("Hello world")
                  .font(.system(size: 120, weight: .black))
                  .foregroundStyle(.black)
              }
            }
            .frame(maxWidth: proxy.size.width * 0.5)
          #endif
        }

      }
    }
  }
}

#Preview {
  SlidePreview {
    SwiftUIViewSlide()
  }
}
