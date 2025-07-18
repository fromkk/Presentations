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
    OverlaySpatialPhotoSlide()  // 10
    NextSlide()  // 11
    SampleCodeSlide()  // 12
    HowToMakeSpatialPhoto()  // 13
    AboutParameters()  // 14
    MakingApproachSlide()  // 15
    ApproachMethodSlide()  // 16
    MultipleiPhonesSlide()  // 17
    SynchronizeShutterSlide()  // 18
    DemoSlide()  // 19
    MirrorlessCameraSlide()  // 20
    CommercialEquipmentSlide()  // 21
    CanUseMitumerundesSlide()  // 22
    DoubleLensSlide()  // 23
    MadeItSlide()  // 24
    ResultsSlide()  // 25
    SummarySlide()  // 26
    PRView()  // 27
  }
  public let theme: any SlideTheme = .default
}

#Preview {
  let configuration = CreateSpatialPhotoSlideConfiguration()
  SlideRouterView(slideIndexController: configuration.slideIndexController)
}
