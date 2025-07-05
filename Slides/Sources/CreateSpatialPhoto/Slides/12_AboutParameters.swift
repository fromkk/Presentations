import SlideKit
import SwiftUI

@Slide
struct AboutParameters: View {
  @Phase
  var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case second
  }

  var body: some View {
    HeaderSlide("3つのパラメータ") {
      Item("`baselineInMillimeters: Double`") {
        if phase == .second {
          Item("カメラ間距離、mm")
          Item("左右のカメラの間隔（レンズ中心間の物理的距離）")
        }
      }
      Item("`horizontalFOV: Double`") {
        if phase == .second {
          Item("水平視野角")
          Item("カメラが水平方向にどれだけ広く撮影しているか（角度で表現）")
        }
      }
      Item("`disparityAdjustment: Double`") {
        if phase == .second {
          Item("視差補正量")
          Item("立体写真の「視差感（飛び出し具合）」を調整するためのパラメータ")
        }
      }
    }
  }

  var transition: AnyTransition {
    .push(from: .trailing)
  }
}

#Preview {
  SlidePreview {
    AboutParameters()
  }
}
