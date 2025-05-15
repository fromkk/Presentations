import Common
import SlideKit
import SwiftUI

@Slide
struct InstallSkip: View {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    HeaderSlide("Installation") {
      Code("brew install skiptools/skip/skip", colorTheme: colorScheme == .dark ? .defaultDark : .presentation)

      Text("> Ensure that the basic development prerequisites are satisfied by running:")
        .font(.system(size: 32).italic())

      Code("skip checkup", colorTheme: colorScheme == .dark ? .defaultDark : .presentation)
    }
  }
}

#Preview {
  InstallSkip()
}
