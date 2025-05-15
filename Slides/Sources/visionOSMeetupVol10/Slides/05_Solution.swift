import SlideKit
import SwiftUI

#if os(visionOS)
  import RealityKit
#endif

@Slide
struct SolutionSlide: View {
  @Environment(\.colorScheme) var colorScheme
  @State var isPresentedAlert: Bool = false
  var body: some View {
    HeaderSlide("解決した方法") {
      HStack {
        GeometryReader { proxy in
          VStack {
            Item("hoverEffectなどを利用して、hover時にUIを変化させた")
              .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
              Code(
                """
                Button {
                  isPresentedAlert = true
                } label: {
                  Text("Button")
                }
                .buttonStyle(.primaryButtonStyle)
                .hoverEffect { effect, isActive, _ in
                  effect.scaleEffect(!isActive ? 1 : 1.5)
                }
                """, colorTheme: colorScheme == .dark ? .defaultDark : .presentation, fontSize: 36
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
              depth: 0.5)
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
                .buttonStyle(.primaryButtonStyle)
                .hoverEffect { effect, isActive, _ in
                  effect.scaleEffect(!isActive ? 1 : 1.5)
                }
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
    SolutionSlide()
  }
}
