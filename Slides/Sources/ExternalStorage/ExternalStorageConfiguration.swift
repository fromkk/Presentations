import Common
import SelfIntroduce
import SlideKit
import SwiftUI

#if os(iOS)
  public struct ExternalStorageConfiguration: SlideConfigurationInterface {
    public init() {}

    public nonisolated static let id: String = "external-storage"
    public nonisolated var id: String { Self.id }
    public static var title: String = "2025/09/21 独自UIで実現する外部ストレージデバイスの読み書き"
    public let size: CGSize = SlideSize.standard16_9
    public let slideIndexController = SlideIndexController {
      TitleSlide()
      SelfIntroduce(transition: .push(from: .trailing))
      HistorySlide()
      AboutCamera()
      LensAndSensor()
      WhatToDoWithCapturedPhotos()
      SaveAPhotoToExternalStorage()
      FileExporterSlide()
      AVExternalStorageDeviceSlide()
      ExternalStorageAuthorization()
      ExternalStorageObservation()
      NextAvailableUrls()
      SaveTakenPhoto()
      TakenPhotos()
      FileImporterSlide()
      ImageCaptureCoreSlide()
      ImageCaptureCoreClassesSlide()
      HowToUseSlide()
      OtherSlide()
      MoreSlide()
      SummarySlide()
      AboutKyu()
      PamphletSlide()
      PRSlide()
      KanagawaSwiftSlide()
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
