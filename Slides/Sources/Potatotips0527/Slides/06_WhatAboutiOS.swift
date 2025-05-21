import SlideKit
import SwiftUI

@Slide
struct WhatAboutiOSSlide: View {
  @State var isShowThinkingFace: Bool = false

  var body: some View {
    HeaderSlide(
      header: {
        Button {
          withAnimation {
            isShowThinkingFace.toggle()
          }
        } label: {
          Text("iOSで空間写真を表示するには？")
            .font(.system(size: 86))
        }
        .buttonStyle(.plain)

      },
      content: {
        if isShowThinkingFace {
          HStack(alignment: .center) {
            Spacer()
            Text("😇")
              .font(.system(size: 300))
            Spacer()
          }
          .transition(.opacity)
        }
      })
  }
}

#Preview {
  SlidePreview {
    WhatAboutiOSSlide()
  }
}
