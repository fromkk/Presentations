import SlideKit
import SwiftUI

@Slide
struct WhatToDoWithCapturedPhotos: View {
  var body: some View {
    HeaderSlide("撮影した写真をどうするか") {
      Item("通常はカメラロールに保存")
      Item("ここでは外部ストレージに保存したい")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    WhatToDoWithCapturedPhotos()
  }
}
