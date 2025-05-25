import SlideKit
import SwiftUI

#if os(visionOS)
  import RealityKit
#endif

@Slide
struct PlainButtonSlide: View {
  @Environment(\.colorScheme) var colorScheme
  @State var isPresentedAlert: Bool = false
  var body: some View {
    HeaderSlide("buttonStyle に .plain を設定してみる") {
      HStack {
        GeometryReader { proxy in
          ScrollView {
            VStack {
              Code(
                """
                Button {
                  // TODO: some action
                } label: {
                  Text("Button")
                }
                .buttonStyle(.plain)
                """,
                syntaxHighlighter: colorScheme == .dark ? .presentationDark(fontSize: 32) : .presentation(fontSize: 32)
              )
              .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
          .frame(maxWidth: .infinity)
        }
        #if os(visionOS)
          RealityView { content, attachments in
            let mesh = MeshResource.generateBox(
              width: 0.5,
              height: 0.5,
              depth: 0.5
            )
            let material = SimpleMaterial(color: .white, isMetallic: false)
            let boxEntity = ModelEntity(mesh: mesh, materials: [material])
            content.add(boxEntity)
            if let button = attachments.entity(for: "button") {
              button.position = [0, 0, 0.26]
              content.add(button)
            }
          } attachments: {
            Attachment(id: "button") {
              HStack {
                Button {
                  isPresentedAlert = true
                } label: {
                  Text("Button")
                }
                .buttonStyle(.plain)
                .padding(16)
              }
              .frame(maxWidth: .infinity)
            }
          }
          .alert("ボタンが押されました", isPresented: $isPresentedAlert, actions: {})
        #endif
      }
    }
  }
}

#Preview {
  SlidePreview {
    PlainButtonSlide()
  }
}
