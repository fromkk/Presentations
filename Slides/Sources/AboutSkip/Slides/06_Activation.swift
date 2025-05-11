import SlideKit
import SwiftUI

@Slide
struct Activation: View {
  var body: some View {
    HeaderSlide("Activation") {
      Code("skip hostid")

      Text("https://skip.tools/eval/")

      Code("~/.skiptools/skipkey.env")
    }
  }
}

#Preview {
  Activation()
}
