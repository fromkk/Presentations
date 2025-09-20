import SlideKit
import SwiftUI

@Slide
struct ImageCaptureCoreClassesSlide: View {
  var body: some View {
    HeaderSlide("ImageCaptureCoreでよく使うクラス") {
      ScrollView {
        VStack(alignment: .leading, spacing: 24) {
          Item("ICDeviceBrowser") {
            Item("外部ストレージデバイスを検出するためのブラウザ")
            Item("start()/stop()で探索を制御し、delegateでイベントを受け取る")
          }
          Item("ICDevice") {
            Item("接続されたデバイスの基本クラス")
            Item("nameやtransportTypeなど共通情報を参照できる")
          }
          Item("ICCameraDevice") {
            Item("カメラやiPhoneなどのメディアデバイスを表現")
            Item("contentCatalogPercentCompletedで読み込み状況を確認")
            Item("requestOpenSession()/requestCloseSession()でセッション管理")
          }
          Item("ICCameraItem / ICCameraFile") {
            Item("デバイス上のメディアを表すモデル")
            Item("requestThumbnail()やrequestSecurityScopedURL()でファイル取得")
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    ImageCaptureCore.frameworkを使う際によく登場するクラスを整理します。
    デバイス検出にはICDeviceBrowser、デバイスの共通インターフェースがICDeviceです。
    メディアを扱う場合はICCameraDeviceからセッションを開き、ICCameraItemやICCameraFileでファイルへアクセスします。
    それぞれの役割を押さえておくことでAPIの全体像が掴みやすくなります。
    """
}

#Preview {
  SlidePreview {
    ImageCaptureCoreClassesSlide()
  }
}
