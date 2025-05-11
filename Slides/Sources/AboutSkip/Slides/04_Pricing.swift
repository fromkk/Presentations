import SlideKit
import SwiftUI

@Slide
struct Pricing: View {
  var body: some View {
    HeaderSlide("Pricing") {
      HStack {
        Spacer()

        Image(.pricing)
          .resizable()
          .aspectRatio(contentMode: .fit)

        Spacer()
      }
    }
  }
}

#Preview {
  Pricing()
}
