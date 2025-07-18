import Photos
import PhotosUI
import SwiftUI

func loadImage(from item: PhotosPickerItem) async throws -> URL? {
  guard let data = try await item.loadTransferable(type: Data.self) else {
    return nil
  }
  let temporaryDirectoryURL = FileManager.default.temporaryDirectory
  let uniqueFileName = UUID().uuidString
  let imageURL = temporaryDirectoryURL.appendingPathComponent(uniqueFileName)
  try data.write(to: imageURL)
  return imageURL
}
