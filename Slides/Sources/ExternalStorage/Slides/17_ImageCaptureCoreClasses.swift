import SlideKit
import SwiftUI

@Slide
struct ImageCaptureCoreClassesSlide: View {
  var body: some View {
    HeaderSlide("メディアの操作でよく使うAPI") {
      ScrollView {
        VStack(alignment: .leading, spacing: 24) {
          Item("ICDeviceBrowser")
          Item("ICCameraDevice: ICDevice")
          Item("ICCameraFile: ICCameraItem")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    メディアの操作でよく使うAPIを書いています。ICDeviceBrowserでデバイスを検索し、
    ICCameraDeviceでデバイスに関する操作を行い、
    ICCameraFileでファイルの操作を行います。
    次に詳細を見ていきます。
    """
}

#Preview {
  SlidePreview {
    ImageCaptureCoreClassesSlide()
  }
}
