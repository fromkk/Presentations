#if !os(visionOS)

import AVFoundation
import Foundation
import OSLog

@MainActor
@Observable
final class AddExternalStorageStore {
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: "AddExternalStorageStore"
  )

  func saveToExternalStorage(
    _ imageData: Data,
    to device: AVExternalStorageDevice
  ) throws {
    guard
      let url = try device.nextAvailableURLs(
        withPathExtensions: ["jpg"]
      ).first,
      url.startAccessingSecurityScopedResource()
    else {
      throw NSError(
        domain: "ExternalStorageError",
        code: 1,
        userInfo: [NSLocalizedDescriptionKey: "外部ストレージへのアクセスができませんでした"]
      )
    }
    defer {
      url.stopAccessingSecurityScopedResource()
    }
    try imageData.write(to: url)
    logger.info("imageData saved to url")
  }
}

#endif
