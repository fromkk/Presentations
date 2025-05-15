import SlideKit
import SwiftUI

@Slide
struct CreatingApp: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    HeaderSlide("Creating App") {
      Text("Transpiled mode")
        .font(.system(size: 32))

      Code(
        "skip init --appid=bundle.id project-name AppName",
        colorTheme: colorScheme == .dark ? .defaultDark : .presentation,
        fontSize: 32
      )

      Text("Native mode")
        .font(.system(size: 32))

      Code(
        "skip init --native-model --appid=bundle.id project-name AppName AppNameModel",
        colorTheme: colorScheme == .dark ? .defaultDark : .presentation,
        fontSize: 32
      )
    }
  }
}

#Preview {
  CreatingApp()
}
