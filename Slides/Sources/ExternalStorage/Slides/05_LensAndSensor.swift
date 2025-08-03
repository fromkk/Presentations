import SlideKit
import SwiftUI

@Slide
struct LensAndSensor: View {
  var body: some View {
    HeaderSlide("レンズとセンサー") {
      Item("自作するのは現実的じゃないのでここではありものを利用する")
      Item("SIGMA fpがUVCに対応しているので利用してみる")
    }
  }
  
  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    LensAndSensor()
  }
}
