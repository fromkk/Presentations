import Common
import Exhivision
import SelfIntroduce
import SlideKit
import SwiftUI

public struct MitumerundesuSpatialPhotoSlideConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "mitumerundesu-spatial-photo"
  public static var title: String = "空間写真を作りたい！"
  public let size = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce(transition: .push(from: .trailing))
    AboutExhivision(transition: .push(from: .trailing))
    AboutSpatialPhoto1Slide()
    AboutSpatialPhoto2Slide()
    WWDC()
    BeforeSlide()
    SampleCodeSlide()
  }
  public let theme: any SlideTheme = .default
}
