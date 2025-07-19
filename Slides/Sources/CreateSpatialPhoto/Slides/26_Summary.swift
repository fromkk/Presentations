import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  let syncCameraURL = URL(string: "https://github.com/fromkk/SyncCamera")!
  let spatialPhotoSamplerURL = URL(string: "https://github.com/fromkk/SpatialPhoto-Sampler")!
  @State var syncCameraQRCode: CGImage?
  @State var spatialPhotoSamplerQRCode: CGImage?
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    HeaderSlide("まとめ") {
      Item("空間写真を作る方法を調べてみた")
      Item("iPhone 2台を使って作ってみた")
      Item("ミラーレスカメラで作れないか模索してみた")

      Text("GitHub")
      HStack(spacing: 32) {
        VStack {
          Text("SyncCamera")
          if let syncCameraQRCode {
            Image(syncCameraQRCode, scale: 1, label: Text("QRCode"))
                .resizable()
                .frame(width: 280, height: 280)
                .scaledToFit()
          }
          Text(syncCameraURL.absoluteString)
            .font(.system(size: 40))
        }
        VStack {
          Text("SpatialPhoto-Sampler")
          if let spatialPhotoSamplerQRCode {
            Image(spatialPhotoSamplerQRCode, scale: 1, label: Text("QRCode"))
                .resizable()
                .frame(width: 280, height: 280)
                .scaledToFit()
          }
          Text(spatialPhotoSamplerURL.absoluteString)
            .font(.system(size: 40))
        }
      }
    }
    .onAppear {
      syncCameraQRCode = createQRCode(syncCameraURL)
      spatialPhotoSamplerQRCode = createQRCode(spatialPhotoSamplerURL)
    }
  }

  func createQRCode(_ url: URL) -> CGImage? {
    let generator = QRCodeGenerator()
    guard
      let ciImage = generator(url.absoluteString, tintColor: colorScheme == .dark ? .white : .black)
    else { return nil }
    let context = CIContext()
    return context.createCGImage(ciImage, from: ciImage.extent)
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
