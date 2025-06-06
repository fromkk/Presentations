import Common
import SelfIntroduce
import SlideKit
import SwiftUI

public struct SwiftUITransitionSlideConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "swiftui-transition"
  public var title: String = "SwiftUIのTransitionの世界"
  public let size = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
  }
  public let theme: any SlideTheme = .default
}
