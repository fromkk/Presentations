//
//  KanagawaSwiftSlide.swift
//  Slides
//
//  Created by Kazuya Ueoka on 2025/09/14.
//

import Common
import CoreGraphics
import CoreImage
import SlideKit
import SwiftUI

@Slide
struct KanagawaSwiftSlide: View {
  @Environment(\.colorScheme) var colorScheme
  @State var qrCode: CGImage?
  let eventURL = URL(
    string: "https://japan-region-swift.connpass.com/event/365671/"
  )!

  var body: some View {
    HeaderSlide("Kanagawa.swift #2") {
      HStack {
        Image(.kanagawaSwift)
          .resizable()
          .frame(maxWidth: 1024, maxHeight: .infinity)
          .aspectRatio(contentMode: .fit)

        VStack {
          if let qrCode {
            Image(qrCode, scale: 1, label: Text("QRCode"))
              .resizable()
              .frame(width: 280, height: 280)
              .scaledToFit()
              .transition(.opacity)
          }

          Text(eventURL.absoluteString)
            .font(.system(size: 32))
            .multilineTextAlignment(.center)
        }
      }
    }
    .onAppear {
      createQRCodeImage()
    }
  }

  func createQRCodeImage() {
    qrCode = createQRCode(eventURL)
  }

  func createQRCode(_ url: URL) -> CGImage? {
    let generator = QRCodeGenerator()
    guard
      let ciImage = generator(
        url.absoluteString,
        tintColor: colorScheme == .dark ? .white : .black
      )
    else { return nil }
    let context = CIContext()
    return context.createCGImage(ciImage, from: ciImage.extent)
  }

  var script: String = """
    あと11/2に鎌倉のカヤックさんの会場をお借りして第二回Kanagawa.swiftもやります。
    是非お越しください。
    以上です。ご清聴ありがとうございました。
    """

  var transition: AnyTransition {
    .scale.combined(with: .opacity)
  }
}

#Preview {
  SlidePreview {
    KanagawaSwiftSlide()
  }
}
