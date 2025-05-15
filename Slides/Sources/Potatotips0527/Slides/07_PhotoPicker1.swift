import SlideKit
import SwiftUI

@Slide
struct PhotoPicker1Slide: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    HeaderSlide("Pick a spatial photo") {
      Code("""
        .photosPicker(
          isPresented: $isPhotosPickerPresented,
          selection: $selection,
          matching: .all(of: [.images, .spatialMedia])
        )
        """, colorTheme: colorScheme == .dark ? .defaultDark : .presentation)
    }
  }
}

#Preview {
  SlidePreview {
    PhotoPicker1Slide()
  }
}
