import Common
import SelfIntroduce
import SlideKit
import SwiftUI

public struct AboutSkipSlideConfiguration: SlideConfigurationInterface {
  public let id: String = "aboutSkip"

  public var title: String = "About Skip"

  public let size = SlideSize.standard16_9

  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
    AboutSkip()
    Pricing()
    InstallSkip()
    Activation()
    CreatingApp()
  }

  public let theme: any SlideTheme = .default

  public init() {}
}
