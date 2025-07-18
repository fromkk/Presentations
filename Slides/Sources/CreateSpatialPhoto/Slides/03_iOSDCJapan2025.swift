import SlideKit
import SwiftUI

@Slide
struct iOSDCJapan2025Slide: View {
  @Phase
  var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case second
    case third
    case fourth
    case fifth
    case sixth
  }

  var body: some View {
    HeaderSlide("iOSDC Japan 2025") {
      HStack {
        Spacer()

        ZStack(alignment: .center) {
          switch phase {
          case .initial:
            EmptyView()
          case .second, .third:
            Image(.iosdc1)
            if phase == .third {
              AcceptedView()
                .rotationEffect(.degrees(-15))
                .transition(.scale.combined(with: .opacity))
            }
          case .fourth, .fifth:
            Image(.iosdc2)
            if phase == .fifth {
              AcceptedView()
                .rotationEffect(.degrees(-15))
                .transition(.scale.combined(with: .opacity))
            }
          case .sixth:
            Image(.iosdc3)
          }
        }
        .animation(.default, value: phase)

        Spacer()
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    iOSDCJapan2025Slide()
  }
}
