import Common
import SelfIntroduce
import SlideKit
import SwiftUI

public struct ExternalStorageConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "external-storage"
  public static var title: String = "独自UIで実現する外部ストレージデバイスの読み書き"
  public let size: CGSize = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce()
    AboutKyuSlide()
    RealityExternalStorageSlide()
    ReadExternalStorageSlide()
    WriteExternalStorageSlide()
    SummarySlide()
  }
  public let theme: any SlideTheme = .default
}
