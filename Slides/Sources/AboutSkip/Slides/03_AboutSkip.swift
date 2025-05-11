import SlideKit
import SwiftUI

@Slide
struct AboutSkip: View {
  var body: some View {
    HeaderSlide("About Skip") {
      Text(
        "> Skip is a new technology for building native iOS and Android apps that is designed for the iOS-first app ecosystem."
      )
      .font(.system(size: 32).italic())
      Text(
        "> With Skip, you work in Xcode, writing in Swift and SwiftUI. Skip acts as your Android team, generating the equivalent Android app. Skip’s goal is to disappear into the background, giving you an uncompromising iOS development experience while its Xcode plugin handles the Android version automatically."
      )
      .font(.system(size: 32).italic())
    }
  }
}

#Preview {
  AboutSkip()
}
