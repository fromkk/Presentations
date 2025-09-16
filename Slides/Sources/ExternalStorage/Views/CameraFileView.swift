import ImageCaptureCore
import SwiftUI

struct CameraFileView: View {
  let file: ICCameraFile

  @State var imageData: Data?

  var body: some View {
    Group {
      if let imageData {
        #if canImport(UIKit)
        Image(uiImage: UIImage(data: imageData)!)
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .aspectRatio(contentMode: .fit)
        #elseif canImport(AppKit)
        Image(nsImage: NSImage(data: imageData)!)
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .aspectRatio(contentMode: .fit)
        #endif
      } else {
        ProgressView()
      }
    }.task {
      try? await showImage()
    }
  }

  private func showImage() async throws {
    let url = try await file.requestSecurityScopedURL()
    guard url.startAccessingSecurityScopedResource() else {
      return
    }
    defer { url.stopAccessingSecurityScopedResource() }
    imageData = try Data(contentsOf: url)
  }
}
