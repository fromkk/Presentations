import SlideKit
import SwiftUI
import YouTubePlayerKit

@Slide
struct WWDC: View {
  let player = YouTubePlayer(
    url: URL(string: "https://www.youtube.com/live/0_DjDdfqtUE?si=mY-aRyEfVXm81mM-&t=1017")!)

  var body: some View {
    YouTubePlayerView(player)
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}
