#if !os(visionOS)
  import AVFoundation
  import Combine
  import Observation

  @Observable
  final class ExternalStorageObservationStore {
    let isSupported: Bool = AVExternalStorageDeviceDiscoverySession.isSupported
    var deviceList: [AVExternalStorageDevice] = []
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []

    func observeDeviceNames() {
      cancellables.removeAll()
      guard
        let discoverySession = AVExternalStorageDeviceDiscoverySession.shared
      else {
        return
      }
      deviceList = discoverySession.externalStorageDevices
      cancellables.insert(
        discoverySession
          .publisher(for: \.externalStorageDevices, options: [.initial, .new])
          .print("observeDeviceNames")
          .assign(to: \.deviceList, on: self)
      )
    }

    func cancel() {
      cancellables.removeAll()
    }
  }
#endif
