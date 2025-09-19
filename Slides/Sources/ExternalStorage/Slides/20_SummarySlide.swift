import Common
import Foundation
import SlideKit
import SwiftUI

@Slide
struct SummarySlide: View {
  let presentationURL: URL = URL(
    string:
      "https://github.com/fromkk/Presentations/tree/main/Slides/Sources/ExternalStorage"
  )!
  @State var presentationQRCode: CGImage?
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    HeaderSlide("まとめ") {
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Item("iPhoneをカメラにするために撮影したデータを外部ストレージに記録・閲覧できるように")
          Item("AVExternalStorageDeviceを利用すればメディアの書き出しが可能に")
          Item("ImageCaptureCore.frameworkを利用すればメディアの読み込み・削除が可能に") {
            Item(
              "特にcontentCatalogPercentCompletedが100にならないと値が取得できない問題にはハマったのでここで紹介"
            )
          }
          Item("https://github.com/mtj0928/SlideKit")
          Item(
            "資料置き場 https://github.com/fromkk/Presentations/tree/main/Slides/Sources/ExternalStorage"
          )
        }

        if let presentationQRCode {
          Image(presentationQRCode, scale: 1, label: Text("QRCode"))
            .resizable()
            .frame(width: 280, height: 280)
            .scaledToFit()
            .transition(.opacity)
        }
      }
    }
    .onAppear {
      presentationQRCode = createQRCode(presentationURL)
    }
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

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    まとめです。
    iPhoneをカメラにするために撮影したデータを外部ストレージに記録・閲覧できるようにしてみました。
    AVExternalStorageDeviceを利用すればメディアの書き出しができることが分かりました。
    ImageCaptureCore.frameworkを利用すればメディアの読み込み・削除が可能なことが分かりました。
    特にcontentCatalogPercentCompletedが100にならないと値が取得できない問題にはハマったので紹介できてよかったです。
    このトークが今後の開発において少しでも参考になれば幸いです。

    このスライドはまつじさんのSlideKitを利用して作成しています。
    資料はこちらのQRコードに置いているので興味のある方は参照してください。
    """
}

#Preview {
  SlidePreview {
    SummarySlide()
  }
}
