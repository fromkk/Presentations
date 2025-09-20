import AVKit
import SlideKit
import SwiftUI

@Slide
struct AboutKyu: View {
  let player = AVPlayer(url: Bundle.module.url(forResource: "kyu", withExtension: "mov")!)
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
    今回のトークは副業でお手伝いしている株式会社TranSeで開発しているkyuというアプリとkyu cameraで連携する中で得た知識になっています。
    このデバイスはWiFiやBluetoothなどの通信機能を排除する前提という中での挑戦でした。無事リリースできてよかったです。
    こういうデバイス連携周りの開発に興味ある方がいましたら是非お話ししましょう。
    """
}
