import AVKit
import SlideKit
import SwiftUI

@Slide
struct ResultSlide: View {
  let player = AVPlayer(url: Bundle.module.url(forResource: "1123", withExtension: "mov")!)
  var body: some View {
    VideoPlayer(player: player)
      .onAppear {
        player.seek(to: .zero)
        player.play()
      }
      .allowsHitTesting(false)
  }

  var transition: AnyTransition = .scale.combined(with: .opacity)

  var script: String = """
    これでSlideKitで作成したスライドをリモート接続した端末で操作できるようになりました。
    今もiPadの画面をiPhoneで操作しています。
    """
}

#Preview {
  SlidePreview {
    ResultSlide()
  }
}
