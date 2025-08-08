import SlideKit
import SwiftUI

@Slide
struct TakenPhotos: View {
  var body: some View {
    HeaderSlide("撮ったファイルを閲覧") {
      Item("外部ストレージに保存されたファイルをどうやって閲覧するか")
      Item("AVExternalStorageDevice周りのドキュメントを見ても該当の記述は無さそう")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    TakenPhotos()
  }
}
