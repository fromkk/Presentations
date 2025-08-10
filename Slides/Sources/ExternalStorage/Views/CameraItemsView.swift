@preconcurrency import ImageCaptureCore
import SlideKit
import SwiftUI

struct CameraItemsView: View {
  var device: ICCameraDevice
  @State var mediaFiles: [ICCameraFile] = []

  var body: some View {
    VStack {
      Code(
        """
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
          ForEach(mediaFiles, id: \\.self) {
            CameraItemView(mediaFile: $0)
          }
        }

        struct CameraItemView: View {
          var mediaFile: ICCameraFile
          @State var imageData: Data?

          var body: some View {
            Group {
              if let imageData {
                Image(uiImage: PlatformImage(data: imageData)!)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 300, height: 300)
              } else {
                ProgressView()
              }
            }
            .task {
              imageData = try? await mediaFile.requestThumbnailData()
            }
          }
        }
        """
      )
      LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
        ForEach(mediaFiles, id: \.self) {
          CameraItemView(mediaFile: $0)
        }
      }
    }
    .task {
      mediaFiles = device.mediaFiles?.compactMap { $0 as? ICCameraFile } ?? []
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
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 300, height: 300)
      } else {
        ProgressView()
      }
    }
    .task {
      imageData = try? await mediaFile.requestThumbnailData()
    }
  }
}
