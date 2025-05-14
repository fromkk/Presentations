import SlideKit
import SwiftUI

#if os(visionOS)
  import RealityKit
#endif

@Slide
struct RealityViewSlide: View {
  var body: some View {
    HeaderSlide("RealityViewの表示") {
      HStack {
        VStack {
          Item("SwiftUIベースのアプリで3Dモデルを表示するにはRealityKitを利用")
          ScrollView {
            Code(
              """
              import RealityView
              RealityView { content in
                let mesh = MeshResource.generateBox(
                  width: 0.5,
                  height: 0.5,
                  depth: 0.5)
                let material = SimpleMaterial(color: .white, isMetallic: false)
                let boxEntity = ModelEntity(mesh: mesh, materials: [material])
                content.add(boxEntity)
              }
              """, fontSize: 36)
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
