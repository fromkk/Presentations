import QuickLook
import SlideKit
import SwiftUI

@Slide
struct ResultsSlide: View {
  @State var selectedData: Data?

  @State var imageURL: URL?
  @State var leftImage: CGImage?
  @State var rightImage: CGImage?
  @State var orientation: Image.Orientation?

  var body: some View {
    HeaderSlide("成果") {
      HStack {
        Spacer()

        GenerateSplitView(
          outputURL: Binding(
            get: {
              nil
            },
            set: { url in
              self.imageURL = url
            })
        )
        .quickLookPreview($imageURL)

        Spacer()
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
