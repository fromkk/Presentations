import SlideKit
import SwiftUI

@Slide
struct CommercialEquipmentSlide: View {
  var body: some View {
    HeaderSlide("市販のカメラやレンズ") {
      Item("Canon")
      Item("Blackmagic")
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    CommercialEquipmentSlide()
  }
}
