import Common
import SlideKit
import SwiftUI

@Slide
struct AboutSlide: View {
  var body: some View {
    HeaderSlide("About Wi-Fi Aware") {
      ScrollView {
        VStack(alignment: .leading) {
          Item("WWDC 25で発表された新しいフレームワーク")
          Item("ルーターや中央サーバーに依存せず、デバイス間で直接通信する純粋なピアツーピアネットワーク接続を構築")
          Item("動的かつオンデマンド型で、ハイレベルな認証が行われ、Wi-Fiレイヤーで暗号化されるため安全性が高く、高スループットと低遅延をサポート")
          Item("リアルタイムのビデオ共有、大容量ファイルの転送、アクセサリの制御")
          Item("参考 https://developer.apple.com/jp/videos/play/wwdc2025/228/")
          BackportWebView(
            url: URL(string: "https://developer.apple.com/jp/videos/play/wwdc2025/228/")!
          )
          .aspectRatio(4 / 3, contentMode: .fit)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    Wi-Fi Awareは、ルーターや中央サーバーに依存せず、デバイス間で直接通信する純粋なピアツーピアネットワーク接続を構築できます。 この接続は動的かつオンデマンド型で、ハイレベルな認証が行われ、Wi-Fiレイヤーで暗号化されるため安全性が高く、高スループットと低遅延をサポートします。 通常（インターネット接続など）のWi-Fi接続と並行して動作し、リアルタイムのビデオ共有、大容量ファイルの転送、アクセサリの制御といったローカルでの一時的な体験に最適です。
    """
}

#Preview {
  SlidePreview {
    AboutSlide()
  }
}
