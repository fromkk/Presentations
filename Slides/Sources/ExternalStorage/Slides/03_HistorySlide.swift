import SlideKit
import SwiftUI

@Slide
struct HistorySlide: View {
  var body: some View {
    HeaderSlide("iOSDC Japan 採択歴") {
      Item("2017 自分が欲しいとアプリを作った LT")
      Item("2018 ツールとして利用するUIテスト 15min")
      Item("2019 iOS 12以下でDark modeに対応した地獄の話 LT")
      Item("2020 Catalystに対応したアプリをリリースするまでのリジェクト集 LT")
      Item("2020 iOSには無いmacOS独自機能をCatalystで実装する 20min")
      Item("2021 noteのiOSアプリで実装したアクセシビリティの全て 20min")
      Item("2022 ノートアプリのテキストエディタの解体新書 20min")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    過去に登壇した履歴です。
    もし興味があれば過去のYouTubeなどで見ていただければと思います。
    """
}

#Preview {
  SlidePreview {
    HistorySlide()
  }
}
