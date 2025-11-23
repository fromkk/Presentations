import SlideKit
import SwiftUI

@Slide
struct AboutSlide: View {
  var body: some View {
    HeaderSlide("About Wi-Fi Aware") {
      Item("WWDC 25で発表された新しいフレームワーク")
      Item("Peer to Peerでデバイス同士を接続することができる")
    }
  }
}

#Preview {
  SlidePreview {
    AboutSlide()
  }
}
