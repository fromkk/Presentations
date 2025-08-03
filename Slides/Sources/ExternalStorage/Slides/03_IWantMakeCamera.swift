import SlideKit
import SwiftUI

@Slide
struct IWantMakeCamera: View {
  @Phase
  var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case second
  }

  var body: some View {
    HStack {
      Text("カメラを作りたいと思ったことある人")
        .font(.system(size: 96))

      if phase == .second {
        Text("✋")
          .font(.system(size: 96))
          .transition(.move(edge: .top).combined(with: .scale))
      }
    }
    .animation(.default, value: phase)
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    IWantMakeCamera()
  }
}
