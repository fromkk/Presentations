import Common
import SlideKit
import SwiftUI

public struct iOSDC2025InterviewSlideConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "iosdc2025-interview"
  public static var title: String = "iOSDC2025 Interview"
  public let size = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroductionSlide()
    WhyHostSlide()
    AfterHostingSlide()
    MemorableEventSlide()
    RegionalFlavorSlide()
    OperationDifficultySlide()
    NextEventSlide()
    OtherRegionsSlide()
    MessageForHostsSlide()
    AnythingElseSlide()
  }
  public let theme: any SlideTheme = .default
}
