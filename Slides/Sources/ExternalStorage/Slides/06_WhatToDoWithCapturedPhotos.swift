import SlideKit
import SwiftUI

@Slide
struct WhatToDoWithCapturedPhotos: View {
  var body: some View {
    HeaderSlide("撮影したデータをどうするか") {
      Item("通常はカメラロールに保存")
      Item("ここでは外部ストレージに保存したい")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    さて、撮影した写真や動画はどうしましょうか？
    通常はiPhoneのカメラロールに保存することが多いと思います。
    しかし、ここではiPhoneをカメラにしたいので、外部ストレージに保存したいと思っています。
    """
}

#Preview {
  SlidePreview {
    WhatToDoWithCapturedPhotos()
  }
}
