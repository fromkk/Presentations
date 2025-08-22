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
      if phase == .initial {
        Text("ある時")
          .font(.system(size: 96))
          .transition(.scale.combined(with: .opacity))
      } else {
        Text("カメラを作りたいな")
          .font(.system(size: 96))
          .transition(.scale.combined(with: .opacity))
      }
    }
    .animation(.default, value: phase)
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    ある時、カメラを作りたいなと思いました
    """
}

#Preview {
  SlidePreview {
    IWantMakeCamera()
  }
}
