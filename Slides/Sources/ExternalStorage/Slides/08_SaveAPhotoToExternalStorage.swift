import SlideKit
import SwiftUI

@Slide
struct SaveAPhotoToExternalStorage: View {
  var body: some View {
    HeaderSlide("撮影した画像を外部ストレージに保存する") {
      Item("AVFoundationにAVExternalStorageDeviceというものがある")
      Item("https://developer.apple.com/documentation/avfoundation/avexternalstoragedevice")
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}
