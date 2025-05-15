import SlideKit
import SwiftUI

@Slide
struct Activation: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    HeaderSlide("Activation") {
      Code("skip hostid", colorTheme: colorScheme == .dark ? .defaultDark : .presentation)

      Text("https://skip.tools/eval/")

      Code(
        "~/.skiptools/skipkey.env", colorTheme: colorScheme == .dark ? .defaultDark : .presentation)
    }
  }
}

#Preview {
  Activation()
}
