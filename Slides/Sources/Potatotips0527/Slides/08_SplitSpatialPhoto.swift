import CoreImage
import Photos
import PhotosUI
import SlideKit
import SwiftUI

@Slide
struct SplitSpatialPhotoSlide: View {
  @State var isPhotosPickerPresented: Bool = false
  @State var selectedPhotosPickerItem: PhotosPickerItem?
  @State var leftImage: CGImage?
  @State var rightImage: CGImage?
  @State var orientation: Image.Orientation? = nil

  var body: some View {
    HeaderSlide("左右それぞれの写真を取得してみる") {
      HStack {
        GeometryReader { proxy in
          HStack(spacing: 32) {
            VStack {
              VStack {
                if let leftImage {
                  Image(
                    decorative: leftImage,
                    scale: 1,
                    orientation: orientation ?? .up
                  )
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                }

                if let rightImage {
                  Image(
                    decorative: rightImage,
                    scale: 1,
                    orientation: orientation ?? .up
                  )
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
                        let data = try await pickerItem.loadTransferable(type: Data.self)
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
                import CoreImage
                import Foundation

                extension Data {
                  var splitImages: (CGImage, CGImage)? {
                    guard let src = CGImageSourceCreateWithData(self as CFData, nil) else {
                      return nil
                    }

                    guard
                      let properties = CGImageSourceCopyProperties(src, nil)
                        as? [CFString: Any],
                      let groups = properties[kCGImagePropertyGroups] as? [[CFString: Any]],
                      let stereoPairGroup = groups.first(where: {
                        $0[kCGImagePropertyGroupType] as? String
                          == (kCGImagePropertyGroupTypeStereoPair as String)
                      }),
                      let leftIndex = stereoPairGroup[kCGImagePropertyGroupImageIndexLeft]
                        as? Int,
                      let rightIndex = stereoPairGroup[kCGImagePropertyGroupImageIndexRight]
                        as? Int,
                      let left = CGImageSourceCreateImageAtIndex(src, leftIndex, nil),
                      let right = CGImageSourceCreateImageAtIndex(src, rightIndex, nil)
                    else {
                      return nil
                    }
                    return (left, right)
                  }

                  var orientation: CGImagePropertyOrientation? {
                    guard
                      let src = CGImageSourceCreateWithData(self as CFData, nil),
                      let property = CGImageSourceCopyProperties(src, nil) as? [CFString: Any],
                      let rawValue = property[kCGImagePropertyOrientation] as? UInt32
                    else {
                      return nil
                    }
                    return CGImagePropertyOrientation(rawValue: rawValue)
                  }
                }

                @State var leftImage: CGImage?
                @State var rightImage: CGImage?
                @State var orientation: Image.Orientation? = nil

                VStack {
                  VStack {
                    if let leftImage {
                      Image(
                        decorative: leftImage,
                        scale: 1,
                        orientation: orientation ?? .up
                      )
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                    }
                    
                    if let rightImage {
                      Image(
                        decorative: rightImage,
                        scale: 1,
                        orientation: orientation ?? .up
                      )
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
                            let data = try await pickerItem.loadTransferable(type: Data.self)
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

                """, fontSize: 24
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
    SplitSpatialPhotoSlide()
  }
}
