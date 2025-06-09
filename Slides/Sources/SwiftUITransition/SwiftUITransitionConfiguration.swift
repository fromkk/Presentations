import Common
import Exhivision
import SelfIntroduce
import SlideKit
import SwiftUI

public struct SwiftUITransitionSlideConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "swiftui-transition"
  public static var title: String = "SwiftUIのTransitionの世界"
  public let size = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
    AboutExhivision()
  }
  public let theme: any SlideTheme = .default
}
