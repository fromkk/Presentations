import SlideKit
import SwiftUI

@Slide
struct InstallSkip: View {
  var body: some View {
    HeaderSlide("Installation") {
      Code("brew install skiptools/skip/skip")

      Text("> Ensure that the basic development prerequisites are satisfied by running:")
        .font(.system(size: 32).italic())

      Code("skip checkup")
    }
  }
}

#Preview {
  InstallSkip()
}
