import AVFoundation

struct ExternalStorageClient: Sendable {
  var devices: @Sendable () -> [String]
  var save: @Sendable (Data) -> Void
}

extension ExternalStorageClient {
  static let liveValue: ExternalStorageClient = Self(
    devices: {
      guard let devices = AVExternalStorageDeviceDiscoverySession.shared?.externalStorageDevices else {
        return []
      }
      return devices.compactMap { $0.displayName }
    },
    save: { data in

    }
  )
}
