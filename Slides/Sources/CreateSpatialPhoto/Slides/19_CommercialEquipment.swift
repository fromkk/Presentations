import SlideKit
import SwiftUI

@Slide
struct CommercialEquipmentSlide: View {
  var body: some View {
    HeaderSlide("市販のカメラやレンズ") {
      HStack {
        VStack(alignment: .leading) {
          Text("Canon")
          Image(.canon)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }

        VStack(alignment: .leading) {
          Text("Blackmagic")
          Image(.blackmagic)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      }
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
