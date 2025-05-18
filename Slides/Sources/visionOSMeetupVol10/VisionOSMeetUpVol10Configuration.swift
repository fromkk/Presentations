import Common
import Exhivision
import SelfIntroduce
import SlideKit
import SwiftUI

public struct VisionOSMeetUpVol10Configuration: SlideConfigurationInterface {
  public init() {}

  public var id: String = "visionos-meetup-vol-10"

  public var title: String = "visionOS Engineer Meetup vol.10 オンラインLT会"

  public var size: CGSize = SlideSize.standard16_9

  public var slideIndexController: SlideIndexController = .init {
    TitleSlide()
    SelfIntroduce()
    AboutExhivision()
    RealityViewSlide()
    SwiftUIViewSlide()
    UINotRespondingSlide()
    SolutionSlide()
    SpatialPhotoSlide()
    SummarySlide()
  }

  public var theme: any SlideKit.SlideTheme = .default

}
