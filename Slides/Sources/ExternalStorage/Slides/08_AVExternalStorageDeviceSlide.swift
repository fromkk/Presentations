#if os(iOS)

  import AVFoundation
  import Common
  import SlideKit
  import SwiftUI

  @Slide
  struct AVExternalStorageDeviceSlide: View {
    @State var isSupported: Bool = AVExternalStorageDeviceDiscoverySession
      .isSupported

    @Phase
    var phase: SlidePhase

    enum SlidePhase: Int, PhasedState {
      case initial
      case second
    }

    let url: URL = URL(
      string:
        "https://developer.apple.com/documentation/avfoundation/avexternalstoragedevice"
    )!

    var body: some View {
      HeaderSlide("AVExternalStorageDevice") {
        switch phase {
        case .initial:
          Item("AVFoundationにAVExternalStorageDeviceというものがある")
          Item("\(url)") {
            BackportWebView(url: url)
          }
        case .second:
          Item("AVExternalStorageDeviceが利用可能か確認する") {
            Item(
              "AVExternalStorageDeviceDiscoverySession.isSupported \(isSupported ? "true" : "false")"
            )
            Item("手元ではiPhoneのみ `true`")
          }
        }
      }
    }

    var transition: AnyTransition = .push(from: .trailing)

    var script: String {
      switch phase {
      case .initial:
        return """
          独自UIでUXを向上させるために色々調べていたところ、AVFoundationにAVExternalStorageDeviceというものがあるのを発見しました。
          """
      case .second:
        return """
          AVExternalStorageDeviceを利用してみます。
          AVExternalStorageDeviceが利用可能か確認するにはAVExternalStorageDeviceDiscoverySession.isSupportedの値を確認します。
          手元で確認したところ、iPhoneの物理デバイスのみでtrueになることを確認しました。
          """
      }
    }
  }

  #Preview {
    SlidePreview {
      AVExternalStorageDeviceSlide()
    }
  }

#endif
