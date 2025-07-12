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
    SynchronizeShutterSlide()  // 16
    DemoSlide()  // 17
    MirrorlessCameraSlide()  // 18
    CommercialEquipmentSlide()  // 19
    CanUseMitumerundesSlide()  // 20
    DoubleLensSlide()  // 21
    MadeItSlide()  // 22
    ResultsSlide()  // 23
    SummarySlide()  // 24
  }
  public let theme: any SlideTheme = .default
}

#Preview {
  let configuration = CreateSpatialPhotoSlideConfiguration()
  SlideRouterView(slideIndexController: configuration.slideIndexController)
}
