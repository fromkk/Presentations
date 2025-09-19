import Common
import SlideKit
import SwiftUI

@Slide
struct WhatToDoWithCapturedPhotos: View {
  @Phase
  var phase: SlidePhase

  enum SlidePhase: Int, Comparable, PhasedState {
    case initial
    case second
    case third
  }

  var body: some View {
    HeaderSlide("撮影したデータをどう保存するか") {
      Item("通常はカメラロール")
      if phase >= .second {
        Item("端末内の容量がないことを考慮したい") {
          if phase >= .third {
            Item("外部ストレージに保存することを検討")
            Item("ユーザーになるべく保存先のことを考えさせたくない")
          }
        }
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String {
    switch phase {
    case .initial:
      return """
        さて、撮影した写真や動画はどう保存しましょうか？
        通常はiPhoneのカメラロール（ライブラリ）に保存することが多いと思います。
        """
    case .second:
      return """
        しかし、端末内の容量が無いことを考慮したいので、
        """
    case .third:
      return """
        外部ストレージに保存することを検討しようと思います。
        """
    }
  }
}

#Preview {
  SlidePreview {
    WhatToDoWithCapturedPhotos()
  }
}
