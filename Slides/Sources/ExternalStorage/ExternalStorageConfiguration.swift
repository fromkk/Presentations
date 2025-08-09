import Common
import SelfIntroduce
import SlideKit
import SwiftUI

#if !os(visionOS)
public struct ExternalStorageConfiguration: SlideConfigurationInterface {
  public init() {}

  public let id: String = "external-storage"
  public static var title: String = "2025/09/21 独自UIで実現する外部ストレージデバイスの読み書き"
  public let size: CGSize = SlideSize.standard16_9
  public let slideIndexController = SlideIndexController {
    TitleSlide()
    SelfIntroduce(transition: .push(from: .trailing))
    AboutKyuSlide()
    IWantMakeCamera()
    AboutCamera()
    LensAndSensor()
    WhatToDoWithCapturedPhotos()
    SaveAPhotoToExternalStorage()
    ExternalStorageAuthorization()
    ExternalStorageObservation()
    NextAvailableUrls()
    SaveTakenPhoto()
    TakenPhotos()
    ImageCaptureCoreSlide()
    HowToUseSlide()
  }
  public let theme: any SlideTheme = .default
}

#Preview {
  let configuration = ExternalStorageConfiguration()
  SlideScreen(slideSize: configuration.size) {
    SlideRouterView(slideIndexController: configuration.slideIndexController)
  }
}
#endif
