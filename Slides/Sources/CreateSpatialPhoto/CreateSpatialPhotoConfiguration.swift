import Common
import Exhivision
import SelfIntroduce
import SlideKit
import SwiftUI

public struct CreateSpatialPhotoSlideConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "create-spatial-photo"
  public static var title: String = "空間写真を作りたい！"
  public let size = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()  // 01
    SelfIntroduce(transition: .push(from: .trailing))  // 02
    AboutExhivision(transition: .push(from: .trailing))  // 03
    AboutSpatialPhoto1Slide()  // 04
    AboutSpatialPhoto2Slide()  // 05
    AboutHEIC()  // 06
    WWDC()  // 07
    BeforeSlide()  // 08
    NextSlide()  // 09
    SampleCodeSlide()  // 10
    HowToMakeSpatialPhoto()  // 11
    AboutParameters()  // 12
    MakingApproachSlide()  // 13
    ApproachMethodSlide()  // 14
    MultipleiPhonesSlide()  // 15
    MirrorlessCameraSlide()  // 16
    CommercialEquipmentSlide()  // 17
    CanUseMitumerundesSlide()  // 18
    WhatIsMitumerundesSlide()  // 19
    DoubleLensSlide()  // 20
    MadeItSlide()  // 21
    ResultsSlide()  // 22
    SummarySlide()  // 23
  }
  public let theme: any SlideTheme = .default
}

#Preview {
  let configuration = CreateSpatialPhotoSlideConfiguration()
  SlideRouterView(slideIndexController: configuration.slideIndexController)
}
