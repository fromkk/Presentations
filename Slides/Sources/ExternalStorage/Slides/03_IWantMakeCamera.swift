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
      Text(phase == .initial ? "ある時" : "カメラを作りたいな")
        .font(.system(size: 96))
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
