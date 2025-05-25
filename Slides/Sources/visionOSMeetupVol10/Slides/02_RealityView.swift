import SlideKit
import SwiftUI

#if os(visionOS)
  import RealityKit
#endif

@Slide
struct RealityViewSlide: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    HeaderSlide("RealityViewの表示") {
      HStack {
        VStack {
          Item("SwiftUIベースのアプリで3Dモデルを表示するにはRealityKitを利用")
          ScrollView {
            Code(
              """
              import RealityKit
              RealityView { content in
                let mesh = MeshResource.generateBox(
                  width: 0.5,
                  height: 0.5,
                  depth: 0.5)
                let material = SimpleMaterial(color: .white, isMetallic: false)
                let boxEntity = ModelEntity(mesh: mesh, materials: [material])
                content.add(boxEntity)
              }
              """,
              syntaxHighlighter: colorScheme == .dark
                ? .presentationDark(fontSize: 32) : .presentation(fontSize: 32)
            )
          }
        }

        #if os(visionOS)
          RealityView { content in
            let mesh = MeshResource.generateBox(width: 0.5, height: 0.5, depth: 0.5)
            let material = SimpleMaterial(color: .white, isMetallic: false)
            let boxEntity = ModelEntity(mesh: mesh, materials: [material])
            content.add(boxEntity)
          }
        #endif
      }
    }
  }
}

#Preview {
  SlidePreview {
    RealityViewSlide()
  }
}
