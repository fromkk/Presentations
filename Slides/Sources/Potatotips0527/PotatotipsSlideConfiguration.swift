import Interfaces
import SlideKit
import SwiftUI

@MainActor
public struct PotatotipsSlideConfiguration: SlideConfigurationInterface {
  public let id: String = "potatotips0527"

  public let size = SlideSize.standard16_9

  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
  }

  public let theme: any SlideTheme = .default

  public init() {}
}
