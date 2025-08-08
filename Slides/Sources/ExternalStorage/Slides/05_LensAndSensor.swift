import SlideKit
import SwiftUI

@Slide
struct LensAndSensor: View {
  var body: some View {
    HeaderSlide("レンズとセンサー") {
      Item("本質じゃないのでここではiPhoneのカメラを利用する")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    LensAndSensor()
  }
}
