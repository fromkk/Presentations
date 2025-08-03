import SlideKit
import SwiftUI

@Slide
struct LensAndSensor: View {
  var body: some View {
    HeaderSlide("レンズ・センサー") {
      CameraView()
    }
  }
}

#Preview {
  SlidePreview {
    LensAndSensor()
  }
}
