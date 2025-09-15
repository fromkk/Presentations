import ImageCaptureCore
import SwiftUI

struct CameraFileView: View {
  let file: ICCameraFile

  @State var imageData: Data?

  var body: some View {
    Group {
      if let imageData {
        Image(uiImage: UIImage(data: imageData)!)
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .aspectRatio(contentMode: .fit)
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
