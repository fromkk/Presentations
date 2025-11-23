import Common
import SelfIntroduce
import SlideKit
import SwiftUI

#if os(iOS)
  public struct WifiAwareSlidesConfiguration: SlideConfigurationInterface {
    public nonisolated static let id: String = "wifi-aware"

    public init() {}

    public nonisolated var id: String { Self.id }
    public static var title: String = "2025/11/23 Wi-Fi Aware試してみた"
    public let size: CGSize = SlideSize.standard16_9
    public let slideIndexController = SlideIndexController {
      TitleSlide()
      SelfIntroduce(transition: .push(from: .trailing))
      AboutSlide()
    }
    public let theme: any SlideTheme = .default
  }

  #Preview {
    let configuration = WifiAwareSlidesConfiguration()
    SlideScreen(slideSize: configuration.size) {
      SlideRouterView(slideIndexController: configuration.slideIndexController)
    }
  }
#endif
