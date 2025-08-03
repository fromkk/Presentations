import SlideKit
import SwiftUI

@Slide
struct LensAndSensor: View {
  var body: some View {
    HeaderSlide("レンズ・センサー") {
      CameraView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

#Preview {
  SlidePreview {
    LensAndSensor()
  }
}
