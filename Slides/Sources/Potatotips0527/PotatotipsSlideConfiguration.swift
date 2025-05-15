import Exhivision
import Common
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
    AboutExhivision()
    QuestionSpatialPhotoSlide()
    AboutSpatialPhotoSlide()
    DeepDiveSpatialPhotoSlide()
    VisionOSSlide()
    WhatAboutiOSSlide()
    PhotoPickerSlide()
    SplitSpatialPhotoSlide()
    OverlaySpatialPhotoSlide()
    SummarySlide()
  }

  public let theme: any SlideTheme = .default

  public init() {}
}
