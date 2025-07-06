import SlideKit
import SwiftUI

@Slide
struct SynchronizeShutterSlide: View {
  var body: some View {
    HeaderSlide("何かしらの方法でシャッターを同時に押せないか") {
      Item("Multipeer Connectivityを利用してシャッターイベントを同期")
      Item("撮影したデータを転送")
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    SynchronizeShutterSlide()
  }
}