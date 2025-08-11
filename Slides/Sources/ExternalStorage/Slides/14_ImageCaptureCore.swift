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

  var script: String = """
    そんな中ちょうど昨年のiOSDCでAppleのエヴァンジェリストの方を紹介してもらい一緒に調査をする機会を得ることができました。
    メールでやり取りしている中で、ImageCaptureCore.frameworkというフレームワークを発見することができ、深掘りすることにしました。
    その名の通り、イメージキャプチャアプリというmacOSアプリで利用されているframeworkです。
    """
}

#Preview {
  SlidePreview {
    ImageCaptureCoreSlide()
  }
}
