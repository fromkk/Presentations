import Common
import Exhivision
import SelfIntroduce
import SlideKit
import SwiftUI

public struct Potatotips0527SlideConfiguration: SlideConfigurationInterface {
  public let id: String = "potatotips0527"

  public static var title: String = "potatotips 05/27"

  public let size = SlideSize.standard16_9

  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
    AboutExhivision()
    QuestionSpatialPhotoSlide()
    AboutSpatialPhoto1Slide()
    AboutSpatialPhoto2Slide()
    DeepDiveSpatialPhotoSlide()
    VisionOSSlide()
    WhatAboutiOSSlide()
    PhotoPicker1Slide()
    PhotoPicker2Slide()
    SplitSpatialPhoto1Slide()
    SplitSpatialPhoto2Slide()
    OverlaySpatialPhotoSlide()
    CompletedSlide()
    SummarySlide()
  }

  public let theme: any SlideTheme = .default

  public init() {}
}
