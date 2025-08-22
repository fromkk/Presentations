import AVFoundation
import Combine
import Observation
import SlideKit
import SwiftUI

#if !os(visionOS)
  @Slide
  struct ExternalStorageObservation: View, Sendable {
    @State var store: ExternalStorageObservationStore

    init() {
      store = ExternalStorageObservationStore()
    }

    var body: some View {
      HeaderSlide("デバイスの接続状態の監視") {
        Item(
          "AVExternalStorageDeviceDiscoverySession.shared?.externalStorageDevices"
        ) {
          if store.deviceList.isEmpty {
            Item("端末が接続されていません")
              .transition(.scale.combined(with: .opacity))
          } else {
            ForEach(store.deviceList, id: \.self) { device in
              Item("\(device.displayName ?? "No Name")")
                .transition(.scale.combined(with: .opacity))
            }
          }
        }
      }
      .task {
        store.observeDeviceNames()
      }
      .onDisappear {
        store.cancel()
      }
      .animation(.default, value: store.deviceList)
    }

    var transition: AnyTransition = .push(from: .trailing)

    var script: String = """
      デバイスの接続状態を監視します。
      AVExternalStorageDeviceDiscoverySession.shared?.externalStorageDevicesはKVOに対応しているので、この値を監視しているだけで接続デバイスの一覧を取得することができます。
      ここでUSB-Cに対応した外部ストレージを接続することで「○○○○」と表示されていることが分かります。
      """
  }

  #Preview {
    SlidePreview {
      ExternalStorageObservation()
    }
  }
#endif
