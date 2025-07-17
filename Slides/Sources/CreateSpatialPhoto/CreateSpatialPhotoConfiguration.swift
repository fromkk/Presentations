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
    iOSDCJapan2025Slide()  // 03
    AboutExhivision(transition: .push(from: .trailing))  // 04
    AboutSpatialPhoto1Slide()  // 05
    AboutSpatialPhoto2Slide()  // 06
    AboutHEIC()  // 07
    WWDC()  // 08
    BeforeSlide()  // 09
    NextSlide()  // 10
    SampleCodeSlide()  // 11
    HowToMakeSpatialPhoto()  // 12
    AboutParameters()  // 13
    MakingApproachSlide()  // 14
    ApproachMethodSlide()  // 15
    MultipleiPhonesSlide()  // 16
    SynchronizeShutterSlide()  // 17
    DemoSlide()  // 18
    MirrorlessCameraSlide()  // 19
    CommercialEquipmentSlide()  // 20
    CanUseMitumerundesSlide()  // 21
    DoubleLensSlide()  // 22
    MadeItSlide()  // 23
    ResultsSlide()  // 24
    SummarySlide()  // 25
  }
  public let theme: any SlideTheme = .default
}

#Preview {
  let configuration = CreateSpatialPhotoSlideConfiguration()
  SlideRouterView(slideIndexController: configuration.slideIndexController)
}
