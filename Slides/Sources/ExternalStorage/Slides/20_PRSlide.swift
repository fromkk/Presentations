import Common
import CoreGraphics
import CoreImage
import SlideKit
import SwiftUI

@Slide
struct PRSlide: View {

  @Environment(\.colorScheme) var colorScheme

  @State var tamaRiverQRCode: CGImage?
  @State var denaQRCode: CGImage?
  @State var sansanQRCode: CGImage?
  @State var lyQRCode: CGImage?

  let denaURL = URL(string: "https://dena.connpass.com/event/362412/")!
  let sansanURL = URL(string: "https://sansan.connpass.com/event/362403/")!
  let lyURL = URL(string: "https://lycorptech-jp.connpass.com/event/362636/")!

  var body: some View {
    HeaderSlide("PR") {
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
              .transition(.opacity)
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
              .transition(.opacity)
          }

          Text(sansanURL.absoluteString)
            .font(.system(size: 32))
        }

        VStack {
          Text("extension DC @LINEヤフー 10/03")
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
              .transition(.opacity)
          }

          Text(lyURL.absoluteString)
            .font(.system(size: 32))
        }
      }
    }
    .onAppear {
      createQRCodeImages()
    }
  }

  func createQRCodeImages() {
    denaQRCode = createQRCode(denaURL)
    sansanQRCode = createQRCode(sansanURL)
    lyQRCode = createQRCode(lyURL)
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

  var transition: AnyTransition {
    .scale.combined(with: .opacity)
  }

  var script: String = """
    最後に宣伝です。10月の1日から3日にかけて3日連続でextension DCというイベントをやります。
    それぞれDeNAさん、Sansanさん、LINEヤフーさんの会場をお借ります。
    iOSDCで話し足りなかったことなどを発散できる場にできればと思っています。
    是非お越しください。
    """
}

#Preview {
  SlidePreview {
    PRSlide()
  }
}
