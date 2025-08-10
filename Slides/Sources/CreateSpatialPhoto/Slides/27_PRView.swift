import Common
import CoreGraphics
import CoreImage
import SlideKit
import SwiftUI

@Slide
struct PRView: View {
  @Phase
  var slidePhase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case second
  }

  @Environment(\.colorScheme) var colorScheme

  @State var tamaRiverQRCode: CGImage?
  @State var denaQRCode: CGImage?
  @State var sansanQRCode: CGImage?
  @State var lyQRCode: CGImage?

  let tamaRiverURL = URL(string: "https://japan-region-swift.connpass.com/event/357612/")!
  let denaURL = URL(string: "https://dena.connpass.com/event/362412/")!
  let sansanURL = URL(string: "https://sansan.connpass.com/event/362403/")!
  let lyURL = URL(string: "https://lycorptech-jp.connpass.com/event/362636/")!

  var body: some View {
    HeaderSlide("PR") {
      switch slidePhase {
      case .initial:
        VStack {
          HStack {
            Image(.tamaRiverSwift)
              .resizable()
              .aspectRatio(contentMode: .fit)

            if let tamaRiverQRCode {
              Image(tamaRiverQRCode, scale: 1, label: Text("QRCode"))
                .resizable()
                .frame(width: 300, height: 300)
                .scaledToFit()
            }
          }

          Text(tamaRiverURL.absoluteString)
            .font(.system(size: 64))
        }
      case .second:
        HStack(spacing: 16) {
          VStack {
            Text("extension DC @DeNA 10/01")
              .font(.system(size: 36))
              .frame(maxWidth: .infinity)

            Image(.extensionDc)
              .resizable()
              .frame(width: 280, height: 280)
              .aspectRatio(contentMode: .fit)

            if let denaQRCode {
              Image(denaQRCode, scale: 1, label: Text("QRCode"))
                .resizable()
                .frame(width: 280, height: 280)
                .scaledToFit()
            }

            Text(denaURL.absoluteString)
              .font(.system(size: 32))
          }

          VStack {
            Text("extension DC @Sansan 10/02")
              .font(.system(size: 36))
              .frame(maxWidth: .infinity)

            Image(.extensionDc)
              .resizable()
              .frame(width: 280, height: 280)
              .aspectRatio(contentMode: .fit)

            if let sansanQRCode {
              Image(sansanQRCode, scale: 1, label: Text("QRCode"))
                .resizable()
                .frame(width: 280, height: 280)
                .scaledToFit()
            }

            Text(sansanURL.absoluteString)
              .font(.system(size: 32))
          }

          VStack {
            Text("extension DC @Line Yahoo! 10/03")
              .font(.system(size: 36))
              .frame(maxWidth: .infinity)

            Image(.extensionDc)
              .resizable()
              .frame(width: 280, height: 280)
              .aspectRatio(contentMode: .fit)

            if let lyQRCode {
              Image(lyQRCode, scale: 1, label: Text("QRCode"))
                .resizable()
                .frame(width: 280, height: 280)
                .scaledToFit()
            }

            Text(lyURL.absoluteString)
              .font(.system(size: 32))
          }
        }
      }
    }
    .animation(.default, value: slidePhase)
    .onChange(of: slidePhase) { _, _ in
      handleSlidePhase()
    }
    .onAppear {
      handleSlidePhase()
    }
  }

  func handleSlidePhase() {
    switch slidePhase {
    case .initial:
      tamaRiverQRCode = createQRCode(tamaRiverURL)
    case .second:
      denaQRCode = createQRCode(denaURL)
      sansanQRCode = createQRCode(sansanURL)
      lyQRCode = createQRCode(lyURL)
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
    .scale.combined(with: .opacity)
  }
}

#Preview {
  SlidePreview {
    PRView()
  }
}
