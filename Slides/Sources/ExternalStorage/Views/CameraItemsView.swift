@preconcurrency import ImageCaptureCore
import SwiftUI

#if canImport(UIKit)
typealias PlatformImage = UIImage
#elseif canImport(AppKit)
typealias PlatformImage = NSImage
#endif

struct CameraItemsView: View {
  var device: ICCameraDevice
  @State var mediaFiles: [ICCameraFile] = []
  init(device: ICCameraDevice) {
    self.device = device
  }

  var body: some View {
    LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
      ForEach(mediaFiles, id: \.self) {
        CameraItemView(mediaFile: $0)
      }
    }
    .task {
      for await contentCatalogPercentCompleted in device
        .publisher(for: \.contentCatalogPercentCompleted).values {
        print("contentCatalogPercentCompleted \(contentCatalogPercentCompleted)")
      }
      mediaFiles = device.mediaFiles?.compactMap { $0 as? ICCameraFile } ?? []
      print("mediaFiles \(mediaFiles)")
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
