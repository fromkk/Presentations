import Common
import SlideKit
import SwiftUI

@Slide
struct AboutCamera: View {
  @Phase
  var phase: SlidePhase

  enum SlidePhase: Int, PhasedState, Comparable {
    case initial
    case lens
    case sensor
    case storage
    case largeStorage
  }

  var body: some View {
    HeaderSlide("カメラって？") {
      HStack(spacing: 32) {
        VStack {
          Image(.camera)
          Text("https://www.irasutoya.com/2013/01/blog-post_3939.html")
            .font(.body)
        }

        VStack(alignment: .leading) {
          if phase >= .lens {
            Item {
              Text("レンズ").font(.system(size: 60))
            }
          }
          if phase >= .sensor {
            Item {
              Text("センサー").font(.system(size: 60))
            }
          }
          if phase >= .storage {
            Item {
              Text("ストレージ").font(
                .system(size: phase == .largeStorage ? 120 : 60)
              )
            }
          }

          Spacer()
        }
      }
      .animation(.default, value: phase)
    }
  }
}

#Preview {
  SlidePreview {
    AboutCamera()
  }
}
