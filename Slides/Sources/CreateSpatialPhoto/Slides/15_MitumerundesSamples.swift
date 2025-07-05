import SlideKit
import SwiftUI

@Slide
struct MitumerundesSamplesSlide: View {
  var body: some View {
    HeaderSlide("MITUMERUNDES Samples") {
      ScrollView(.horizontal) {
        HStack(spacing: 0) {
          Image(.MIT_001)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
          Image(.MIT_002)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
          Image(.MIT_003)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
          Image(.MIT_004)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
          Image(.MIT_005)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
          Image(.MIT_006)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
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
    MitumerundesSamplesSlide()
  }
}
