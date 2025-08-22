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
    HeaderSlide("撮影したデータをどうするか") {
      Item("通常はカメラロールに保存")
      if phase >= .second {
        Item("端末内の容量がないことを考慮したい") {
          if phase >= .third {
            Item("外部ストレージに保存することを検討")
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
        さて、撮影した写真や動画はどうしましょうか？
        通常はiPhoneのカメラロールに保存することが多いと思います。
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
