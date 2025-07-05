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
    SelfIntroductionSlide(transition: .push(from: .trailing))
    WhyHostSlide(transition: .push(from: .trailing))
    AfterHostingSlide(transition: .push(from: .trailing))
    MemorableEventSlide(transition: .push(from: .trailing))
    RegionalFlavorSlide(transition: .push(from: .trailing))
    OperationDifficultySlide(transition: .push(from: .trailing))
    NextEventSlide(transition: .push(from: .trailing))
    OtherRegionsSlide(transition: .push(from: .trailing))
    MessageForHostsSlide(transition: .push(from: .trailing))
    AnythingElseSlide(transition: .push(from: .trailing))
  }
  public let theme: any SlideTheme = .default
}
