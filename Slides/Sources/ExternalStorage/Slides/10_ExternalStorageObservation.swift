import AVFoundation
import Combine
import Observation
import SlideKit
import SwiftUI

@Observable
final class ExternalStorageObservationStore {
  let isSupported: Bool = AVExternalStorageDeviceDiscoverySession.isSupported
  var deviceNames: [String] = []
  @ObservationIgnored private var cancellables: Set<AnyCancellable> = []

  func observeDeviceNames() {
    cancellables.removeAll()
    guard let discoverySession = AVExternalStorageDeviceDiscoverySession.shared
    else {
      return
    }
    deviceNames = discoverySession.externalStorageDevices.compactMap(\.displayName)
    cancellables.insert(
      discoverySession
        .publisher(for: \.externalStorageDevices, options: [.initial, .new])
        .map { $0.compactMap(\.displayName) }
        .print("observeDeviceNames")
        .assign(to: \.deviceNames, on: self)
    )
  }

  func cancel() {
    cancellables.removeAll()
  }
}

@Slide
struct ExternalStorageObservation: View, Sendable {
  @Bindable var store: ExternalStorageObservationStore

  init() {
    store = ExternalStorageObservationStore()
  }

  var body: some View {
    HeaderSlide("デバイスの接続の監視") {
      Item(
        "AVExternalStorageDeviceDiscoverySession.isSupported \(store.isSupported ? "true" : "false")"
      )
      if store.isSupported {
        Item(
          "AVExternalStorageDeviceDiscoverySession.shared?.externalStorageDevices"
        ) {
          if store.deviceNames.isEmpty {
            Item("端末が接続されていません")
          } else {
            ForEach(store.deviceNames, id: \.self) { deviceName in
              Item("\(deviceName)")
            }
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
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    ExternalStorageObservation()
  }
}
