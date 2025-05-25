import AVKit
import SlideKit
import SwiftUI

@Slide
struct CompletedSlide: View {
  let player = AVPlayer(
    url: Bundle.module.url(forResource: "exhivision_spatial_photo", withExtension: "mov")!)

  var body: some View {
    VideoPlayer(player: player)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .aspectRatio(contentMode: .fill)
      .padding(0)
      .onAppear {
        player.seek(to: .zero)
        player.play()
      }
  }
}
