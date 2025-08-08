import Foundation
import Photos

@MainActor
@Observable
final class AddPhotoLibraryStore {
  func requestCameraRollAccess() async -> Bool {
    switch PHPhotoLibrary.authorizationStatus(for: .addOnly) {
    case .authorized, .limited:
      return true
    case .notDetermined:
      let result =
        await PHPhotoLibrary
        .requestAuthorization(for: .addOnly)
      return result == .authorized || result == .limited
    case .denied, .restricted:
      return false
    @unknown default:
      return false
    }
  }

  func saveToCameraRoll(_ data: Data) async throws {
    try await PHPhotoLibrary.shared().performChanges { @Sendable in
      let creationRequest = PHAssetCreationRequest.forAsset()
      creationRequest.addResource(
        with: .photo,
        data: data,
        options: nil
      )
    }
  }
}
