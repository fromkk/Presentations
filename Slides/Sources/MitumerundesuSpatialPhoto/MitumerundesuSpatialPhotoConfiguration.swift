import Common
import SelfIntroduce
import SlideKit
import SwiftUI

public struct MitumerundesuSpatialPhotoSlideConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "mitumerundesu-spatial-photo"
  public var title: String = "MITUMERUNDESUで撮った写真を空間写真へ"
  public let size = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
  }
  public let theme: any SlideTheme = .default
}
