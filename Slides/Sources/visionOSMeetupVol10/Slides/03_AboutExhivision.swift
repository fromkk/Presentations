import SlideKit
import SwiftUI

@Slide
struct AboutExhivision: View {
  var body: some View {
    HeaderSlide("About exhivision") {
      Item("Skip製のiOS / Android対応の写真展示アプリ")
      Item("最近ViewerとしてApple Vision Pro対応")
    }
  }
}

#Preview {
  SlidePreview {
    AboutExhivision()
  }
}
