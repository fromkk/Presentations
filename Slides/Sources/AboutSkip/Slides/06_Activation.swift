import SlideKit
import SwiftUI

@Slide
struct Activation: View {
  @Environment(\.colorScheme) var colorScheme
  var body: some View {
    HeaderSlide("Activation") {
      Code(
        "skip hostid",
        syntaxHighlighter: colorScheme == .dark ? .presentationDark : .presentation)

      Text("https://skip.tools/eval/")

      Code(
        "~/.skiptools/skipkey.env",
        syntaxHighlighter: colorScheme == .dark ? .presentationDark : .presentation)
    }
  }
}

#Preview {
  Activation()
}
