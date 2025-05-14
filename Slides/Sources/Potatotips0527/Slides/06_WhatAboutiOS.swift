import SlideKit
import SwiftUI

@Slide
struct WhatAboutiOSSlide: View {
  var body: some View {
    HeaderSlide("iOSで空間写真を表示するには？") {
      HStack(alignment: .center) {
        Spacer()
        Text("😇")
          .font(.system(size: 300))
        Spacer()
      }
    }
  }
}

#Preview {
  SlidePreview {
    WhatAboutiOSSlide()
  }
}
