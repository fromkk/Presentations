import SlideKit
import SwiftUI

@Slide
struct AboutKyuSlide: View {
  var body: some View {
    HeaderSlide("kyu の紹介") {
      Item("iOSアプリを中心に活動")
      Item("ブログやコミュニティで情報発信")
    }
  }
}

#Preview {
  SlidePreview {
    AboutKyuSlide()
  }
}
