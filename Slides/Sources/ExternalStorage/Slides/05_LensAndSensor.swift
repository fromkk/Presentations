import SlideKit
import SwiftUI

@Slide
struct LensAndSensor: View {
  @Phase var phase: SlidePhase
  
  enum SlidePhase: Int, PhasedState {
    case initial
    case captured
  }
  
  @State var imageData: Data?
  @State var error: (any Error)?
  
  var body: some View {
    HeaderSlide("レンズ・センサー") {
      #if canImport(UIKit)
      switch phase {
      case .initial:
        CameraView(
          photoTaken: { data in
            imageData = data
          },
          captureFailed: { error in
            self.error = error
          }
        )
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      case .captured:
        if let imageData, let uiImage = UIImage(data: imageData) {
          Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      }
      #endif
    }
  }
}

#Preview {
  SlidePreview {
    LensAndSensor()
  }
}
