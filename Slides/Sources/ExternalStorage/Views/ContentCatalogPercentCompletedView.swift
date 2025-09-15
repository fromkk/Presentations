@preconcurrency import ImageCaptureCore
import SlideKit
import SwiftUI

#if canImport(UIKit)
  typealias PlatformImage = UIImage
#elseif canImport(AppKit)
  typealias PlatformImage = NSImage
#endif

struct ContentCatalogPercentCompletedView: View {
  var device: ICCameraDevice
  @State var contentCatalogPercentCompleted: Int = 0
  @Environment(\.colorScheme) var colorScheme

  init(device: ICCameraDevice) {
    self.device = device
  }

  var body: some View {
    VStack {
      Code(
        """
        ICCameraDevice.contentCatalogPercentCompleted = \(contentCatalogPercentCompleted)

        func subscribe() async throws {
          try await device.requestOpenSession()
          while device.contentCatalogPercentCompleted < 100 {
            contentCatalogPercentCompleted = device.contentCatalogPercentCompleted
            try await Task.sleep(for: .seconds(0.1))
          }
          contentCatalogPercentCompleted = device.contentCatalogPercentCompleted
        }
        """, syntaxHighlighter: colorScheme == .dark ? .presentationDark : .presentation
      )
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .task {
      try? await device.requestOpenSession()
      while device.contentCatalogPercentCompleted < 100 {
        contentCatalogPercentCompleted = device.contentCatalogPercentCompleted
        try? await Task.sleep(for: .seconds(0.1))
      }
      contentCatalogPercentCompleted = device.contentCatalogPercentCompleted
    }
  }
}
