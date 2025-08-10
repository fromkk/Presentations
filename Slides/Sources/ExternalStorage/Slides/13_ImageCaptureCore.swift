import SlideKit
import SwiftUI

@Slide
struct ImageCaptureCoreSlide: View {
  var body: some View {
    HeaderSlide("ImageCaptureCore.frameworkの発見") {
      ScrollView {
        VStack(alignment: .leading) {
          Item("ちょうど昨年のiOSDCでAppleのエヴァンジェリストの方を紹介してもらい一緒に調査") {
            Image(.imageCaptureCore)
            Item("ImageCaptureCore.frameworkというフレームワークを発見")
            Image(.imageCaptureApp)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    ImageCaptureCoreSlide()
  }
}
