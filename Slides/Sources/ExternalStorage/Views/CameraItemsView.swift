@preconcurrency import ImageCaptureCore
import SlideKit
import SwiftUI

#if canImport(UIKit)
  typealias PlatformImage = UIImage
#elseif canImport(AppKit)
  typealias PlatformImage = NSImage
#endif

struct CameraItemsView: View {

  var device: ICCameraDevice
  @State var mediaFiles: [ICCameraFile] = []
  @State var contentCatalogPercentCompleted: Int = 0
  @State var observation: NSKeyValueObservation?

  init(device: ICCameraDevice) {
    self.device = device
  }

  var body: some View {
    VStack {
      Code(
        "ICCameraDevice.contentCatalogPercentCompleted = \(contentCatalogPercentCompleted)"
      )
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .task {
      try? await device.requestOpenSession()
      while device.contentCatalogPercentCompleted < 100 {
        await MainActor.run {
          contentCatalogPercentCompleted = device.contentCatalogPercentCompleted
        }
        try? await Task.sleep(for: .seconds(0.1))
      }
      // ループ終了後も最終値を反映
      await MainActor.run {
        contentCatalogPercentCompleted = device.contentCatalogPercentCompleted
      }
    }
  }
}

struct CameraItemView: View {
  var mediaFile: ICCameraFile
  @State var imageData: Data?

  var body: some View {
    Group {
      if let imageData {
        Image(uiImage: PlatformImage(data: imageData)!)
      } else {
        ProgressView()
      }
    }
    .task {
      imageData = try? await mediaFile.requestThumbnailData()
    }
  }
}
