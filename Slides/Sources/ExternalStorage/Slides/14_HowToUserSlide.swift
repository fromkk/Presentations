@preconcurrency import ImageCaptureCore
import SlideKit
import SwiftUI

@Slide
struct HowToUseSlide: View {
  @Phase var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
  }

  @State var authorizationStatus: ICAuthorizationStatus = .notDetermined

  var body: some View {
    HeaderSlide("How to use") {
      ScrollView {
        switch phase {
        case .initial:
          VStack(alignment: .leading) {
            Item("アクセス権限を取得")
            HStack(alignment: .top) {
              Code(
                """
                  ICDeviceBrowser().contentsAuthorizationStatus = 
                """
              )
              switch authorizationStatus {
              case .notDetermined:
                VStack(alignment: .leading, spacing: 16) {
                  Text(".notDetermined")
                  Button {
                    requestPermission()
                  } label: {
                    Text(
                      "await ICDeviceBrowser()\n.requestContentsAuthorization()"
                    )
                  }
                  .buttonStyle(.borderedProminent)
                }
              case .authorized:
                Text(".authorized")
              case .denied:
                Text(".denied")
              case .restricted:
                Text(".restricted")
              default:
                Text("unknown")
              }
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
    }
    .animation(.default, value: phase)
    .onAppear {
      checkPermission()
    }
  }

  let browser = ICDeviceBrowser()

  func checkPermission() {
    authorizationStatus = browser.contentsAuthorizationStatus
  }

  func requestPermission() {
    Task {
      authorizationStatus = await browser.requestContentsAuthorization()
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    HowToUseSlide()
  }
}
