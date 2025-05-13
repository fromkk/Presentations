import SlideKit
import SwiftUI

#if canImport(RealityKit)
  import RealityKit
#endif

@Slide
struct UINotRespondingSlide: View {
  @State var isPresentedAlert: Bool = false
  var body: some View {
    HeaderSlide("目線を当ててもUIが反応しない問題にハマった") {
      HStack {
        GeometryReader { proxy in
          ScrollView {
            VStack {
              Item("3D空間に配置したカスタムボタンスタイルを適用したSwiftUIのButtonが目線に反応しない（ように見える）問題")
              Item("ボタンをタップしたくても反応するのか分かりづらい")
              Code(
                """
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
                    Button {
                      // TODO: some action
                    } label: {
                      Text("Button")
                    }
                    .buttonStyle(.primaryButtonStyle)
                  }
                }
                """,
                fontSize: 36
              )
            }
          }
          .frame(maxWidth: .infinity)
        }
        #if canImport(RealityKit)
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
                .buttonStyle(.primaryButtonStyle)
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
    UINotRespondingSlide()
  }
}
