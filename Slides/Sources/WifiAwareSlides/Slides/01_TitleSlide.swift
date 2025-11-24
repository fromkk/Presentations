import SlideKit
import SwiftUI

@Slide
struct TitleSlide: View {
  var body: some View {
    VStack {
      Text("Wi-Fi Aware試してみた")
        .font(.system(size: 128).bold())

      Text("Okinawa.swift")
        .font(.system(size: 64).bold())
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String = """
    Wi-Fi Aware試してみたという内容を発表します。
    """
}

#Preview {
  SlidePreview {
    TitleSlide()
  }
}
