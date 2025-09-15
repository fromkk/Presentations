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

  var script: String = """
    レンズとセンサーについては今回のトークでは本質ではないのでiPhoneのカメラ機能を利用することとします。
    """
}

#Preview {
  SlidePreview {
    LensAndSensor()
  }
}
