import SlideKit
import SwiftUI

@Slide
struct ResultsSlide: View {
  var body: some View {
    HeaderSlide("成果") {
      ScrollView(.horizontal) {
        HStack {
          Image(.NIT_001)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: .infinity)
          Image(.NIT_002)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: .infinity)
          Image(.NIT_003)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: .infinity)
          Image(.NIT_004)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: .infinity)
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
    ResultsSlide()
  }
}
