import Interfaces
import SelfIntroduce
import SlideKit
import SwiftUI

public struct Potatotips0527SlideConfiguration: SlideConfigurationInterface {
  public let id: String = "potatotips0527"

  public var title: String = "potatotips 05/27"

  public let size = SlideSize.standard16_9

  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
    QuestionSpatialPhotoSlide()
    AboutSpatialPhotoSlide()
    DeepDiveSpatialPhotoSlide()
    PhotoPickerSlide()
    SplitSpatialPhotoSlide()
  }

  public let theme: any SlideTheme = .default

  public init() {}
}
