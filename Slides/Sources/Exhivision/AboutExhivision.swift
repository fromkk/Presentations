import AVKit
import SlideKit
import SwiftUI

@Slide
public struct AboutExhivision: View {
  public init() {}
  let player = AVPlayer(url: Bundle.module.url(forResource: "exhivision", withExtension: "mov")!)

  public var body: some View {
    ZStack {
      VideoPlayer(player: player)
        .onAppear {
          player.seek(to: .zero)
          player.play()
        }
        .allowsHitTesting(false)

      #if canImport(UIKit)
        Color(uiColor: .systemBackground).opacity(0.25)
          .allowsHitTesting(false)
      #elseif canImport(AppKit)
        Color(nsColor: .windowBackgroundColor).opacity(0.25)
          .allowsHitTesting(false)
      #endif

      HeaderSlide("About exhivision") {
        Item("Skip製のiOS / Android対応の写真展示アプリ")
        Item("viewerとしてApple Vision Pro対応")
        Item("iOS https://apps.apple.com/app/exhivision/id6743517041")
        Item("Android https://play.google.com/store/apps/details?id=me.fromkk.PhotoExhibition")
        Item("viewer(visionOS) https://apps.apple.com/us/app/exhivision-viewer/id6745221004")

        HStack {
          Image(.appstore)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)

          Image(.googlePlayBadge)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 280)
        }
      }
    }
  }
}

#Preview {
  SlidePreview {
    AboutExhivision()
  }
}
