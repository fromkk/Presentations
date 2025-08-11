import SlideKit
import SwiftUI

@Slide
struct AboutKyu: View {
  var body: some View {
    Text("TODO: add movie")
  }

  var transition: AnyTransition = .scale.combined(with: .opacity)

  var script: String = """
    今回のトークは副業でお手伝いしている株式会社TranSeで開発しているkyuというアプリとkyu cameraで連携する中で得た知識になっています。
    こういうデバイス連携周りの開発に興味ある方がいましたら是非お話ししましょう。
    """
}
