import Photos
import PhotosUI
import SlideKit
import SwiftUI

@Slide
struct PhotoPicker2Slide: View {
  @Environment(\.colorScheme) var colorScheme

  @State var isPhotosPickerPresented: Bool = false
  @State var selectedPhotosPickerItem: PhotosPickerItem?
  @State var imageURL: URL?

  var body: some View {
    HeaderSlide("空間写真を表示してみる") {
      GeometryReader { proxy in
        HStack(spacing: 32) {
          VStack {
            AsyncImage(url: imageURL) { context in
              if let image = context.image {
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
              }
            }

            Button {
              isPhotosPickerPresented = true
            } label: {
              Text("Pick Spatial Photo")
                .foregroundStyle(.white)
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: proxy.size.width / 2)
            .photosPicker(
              isPresented: $isPhotosPickerPresented,
              selection: Binding<PhotosPickerItem?>(
                get: {
                  selectedPhotosPickerItem
                },
                set: { pickerItem in
                  selectedPhotosPickerItem = pickerItem
                  Task {
                    if let pickerItem {
                      imageURL = try await loadImage(from: pickerItem)
                    }
                  }
                }
              ),
              matching: .all(of: [.images, .spatialMedia])
            )
          }
          .frame(maxWidth: proxy.size.width / 2)

          ScrollView {
            Code(
              """
              @State var isPhotosPickerPresented: Bool = false
              @State var selectedPhotosPickerItem: PhotosPickerItem?
              @State var imageURL: URL?

              AsyncImage(url: imageURL) { context in
                if let image = context.image {
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
              }

              Button {
                isPhotosPickerPresented = true
              } label: {
                Text("Pick Spatial Photo")
              }
              .photosPicker(
                isPresented: $isPhotosPickerPresented,
                selection: Binding<PhotosPickerItem?>(
                  get: {
                    selectedPhotosPickerItem
                  },
                  set: { pickerItem in
                    selectedPhotosPickerItem = pickerItem
                    Task {
                      if let pickerItem {
                        imageURL = try await loadImage(from: pickerItem)
                      }
                    }
                  }
                ),
                matching: .spatialMedia
              )

              private func loadImage(from item: PhotosPickerItem) async throws -> URL? {
                guard let data = try await item.loadTransferable(type: Data.self) else {
                  return nil
                }
                let temporaryDirectoryURL = FileManager.default.temporaryDirectory
                let uniqueFileName = UUID().uuidString
                let imageURL = temporaryDirectoryURL.appendingPathComponent(uniqueFileName)
                try data.write(to: imageURL)
                return imageURL
              }
              """, colorTheme: colorScheme == .dark ? .defaultDark : .presentation, fontSize: 24
            )
            .frame(maxWidth: .infinity)
          }
        }
      }
    }
  }
}

#Preview {
  SlidePreview {
    PhotoPicker2Slide()
  }
}
