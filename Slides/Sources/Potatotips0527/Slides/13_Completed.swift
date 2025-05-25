import AVKit
import SlideKit
import SwiftUI

@Slide
struct CompletedSlide: View {
  let player: AVPlayer
  @State var isMuted: Bool = true

  init() {
    try? AVAudioSession.sharedInstance().setCategory(
      .playback, mode: .default, options: [.mixWithOthers])
    self.player = AVPlayer(
      url: Bundle.module.url(forResource: "exhivision_spatial_photo", withExtension: "mov")!)
    self.player.isMuted = true
    self.isMuted = player.isMuted
  }

  var body: some View {
    let _ = Self._printChanges()

    ZStack(alignment: .topTrailing) {
      VideoPlayer(player: player)

      Button {
        player.isMuted.toggle()
        isMuted = player.isMuted
      } label: {
        if isMuted {
          Image(systemName: "speaker.slash")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
        } else {
          Image(systemName: "speaker")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
        }
      }
      .padding()
      .accessibilityLabel(
        isMuted ? Text("ミュート解除") : Text("ミュート")
      )
    }
    .padding(0)
  }
}

#Preview {
  CompletedSlide()
}
