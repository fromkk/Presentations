import SlideKit
import SwiftUI

@Slide
struct PamphletSlide: View {
  @Phase
  var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case second
  }

  var body: some View {
    HeaderSlide("パンフ記事") {
      ZStack {
        VStack(spacing: 16) {
          ZStack(alignment: .bottomTrailing) {
            Image(.pamphlet)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(maxWidth: .infinity, maxHeight: .infinity)

            Image(.cfp)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 640)
          }
          Text(
            "https://fortee.jp/iosdc-japan-2025/proposal/223ed33e-a135-4dd9-be04-cc7dac8c2fd4"
          )
        }

        if phase == .second {
          Text("フィードバックしてくれよな！！")
            .font(.system(size: 120, weight: .bold))
            .foregroundStyle(.red)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 20, y: 20)
            .rotationEffect(.degrees(20))
            .transition(.push(from: .top))

        }
      }
      .animation(.default, value: phase)
    }
  }

  var transition: AnyTransition {
    .scale.combined(with: .opacity)
  }

  var script: String = """
    最後に宣伝が続きます。
    まずノベルティを受け取った方は皆さん手元にあるであろうパンフレットの記事を書きました。
    Japan-\\(region).swiftの主催者たちに話を聞いて、これから自分の地域で勉強会を開催したいと思っている方々の後押しになればと思っています。
    8ページでCfPを書いたけど結果10ページという超大作になってしまいました。
    是非隅から隅まで読んでフィードバックをお願いします！
    """
}

#Preview {
  SlidePreview {
    PamphletSlide()
  }
}
