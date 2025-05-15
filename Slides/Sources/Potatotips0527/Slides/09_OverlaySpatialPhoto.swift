import Photos
import PhotosUI
import SlideKit
import SwiftUI

@Slide
struct OverlaySpatialPhotoSlide: View {
  @Environment(\.colorScheme) var colorScheme
  
  @State var isPhotosPickerPresented: Bool = false
  @State var selectedPhotosPickerItem: PhotosPickerItem?
  @State var leftImage: CGImage?
  @State var rightImage: CGImage?
  @State var orientation: Image.Orientation? = nil
  @State var value: Double = 0.015
  var body: some View {
    HeaderSlide("左右の写真を重ねてみる") {
      HStack {
        GeometryReader { proxy in
          HStack(spacing: 32) {
            VStack {
              ZStack {
                if let leftImage {
                  Image(
                    decorative: leftImage,
                    scale: 1,
                    orientation: orientation ?? .up
                  )
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .offset(x: -proxy.size.width * value)
                }

                if let rightImage {
                  Image(
                    decorative: rightImage,
                    scale: 1,
                    orientation: orientation ?? .up
                  )
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .opacity(0.5)
                  .offset(x: proxy.size.width * value)
                  .blendMode(.normal)
                }
              }
              .compositingGroup()
              .aspectRatio(1, contentMode: .fit)

              Slider(
                value: $value,
                in: 0...0.03
              )
              .frame(maxWidth: 500)

              Button {
                isPhotosPickerPresented = true
              } label: {
                Text("Pick Spatial Photo")
                  .foregroundStyle(.white)
              }
              .buttonStyle(.borderedProminent)
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
                        let data = try await pickerItem.loadTransferable(
                          type: Data.self
                        )
                        guard let (left, right) = data?.splitImages else {
                          leftImage = nil
                          rightImage = nil
                          return
                        }
                        leftImage = left
                        rightImage = right

                        switch data?.orientation {
                        case .up:
                          orientation = .up
                        case .upMirrored:
                          orientation = .upMirrored
                        case .down:
                          orientation = .down
                        case .downMirrored:
                          orientation = .downMirrored
                        case .left:
                          orientation = .left
                        case .leftMirrored:
                          orientation = .leftMirrored
                        case .right:
                          orientation = .right
                        case .rightMirrored:
                          orientation = .rightMirrored
                        case nil:
                          orientation = .up
                        }
                      }
                    }
                  }
                ),
                matching: .spatialMedia
              )
            }
            .frame(maxWidth: proxy.size.width / 2)

            ScrollView {
              Code(
                """
                @State var value: CGFloat = 0
                ZStack {
                  if let leftImage {
                    Image(
                      decorative: leftImage,
                      scale: 1,
                      orientation: orientation ?? .up
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: -proxy.size.width * value)
                  }
                  if let rightImage {
                    Image(
                      decorative: rightImage,
                      scale: 1,
                      orientation: orientation ?? .up
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.5)
                    .offset(x: proxy.size.width * value)
                    .blendMode(.normal)
                  }
                }
                .compositingGroup()
                .aspectRatio(1, contentMode: .fit)
                Slider(
                  value: $value,
                  in: 0...0.03
                )
                """, colorTheme: colorScheme == .dark ? .defaultDark : .presentation, fontSize: 24
              )
              .frame(maxWidth: .infinity)
            }
          }
        }
      }
    }
  }
}

#Preview {
  SlidePreview {
    OverlaySpatialPhotoSlide()
  }
}
