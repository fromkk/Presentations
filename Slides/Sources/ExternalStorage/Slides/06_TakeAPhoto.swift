import SlideKit
import SwiftUI

@Slide
struct TakeAPhoto: View {
  @Phase var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case captured
  }

  @State var imageData: Data?
  @State var error: (any Error)?

  var body: some View {
    HeaderSlide("写真の撮影") {
      Item("AVCaptureDevice.DiscoverySession(deviceTypes: [.external], mediaType: .video, position: .unspecified)")
      #if canImport(UIKit)
        switch phase {
        case .initial:
          CameraView(
            photoTaken: { data in
              imageData = data
              $phase.forward()
            },
            captureFailed: { error in
              self.error = error
            }
          )
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .captured:
          if let imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
              .resizable()
              .aspectRatio(contentMode: .fit)
          }
        }
      #endif
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    TakeAPhoto()
  }
}
