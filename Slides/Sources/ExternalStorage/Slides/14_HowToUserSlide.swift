@preconcurrency import ImageCaptureCore
import SlideKit
import SwiftUI

@Slide
struct HowToUseSlide: View {
  @Phase var phase: SlidePhase

  enum SlidePhase: Int, PhasedState {
    case initial
    case showDevices
    case deviceSelected
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
          .transition(.scale.combined(with: .opacity))
        case .showDevices:
          Group {
            Code("""
                let browser = ICDeviceBrowser()
                browser.delegate = self // ICDeviceBrowserDelegate
                browser.start()
                browser.devices // [ICDevice]?
              """)
            if deviceStore.devices.isEmpty {
              Text("デバイスが接続されていません")
            } else {
              Text("検出済みデバイス")
              ForEach(deviceStore.devices, id: \.self) { device in
                Item {
                  Button {
                    deviceStore.select(device)
                    $phase.forward()
                  } label: {
                    Text("\(device.name ?? "No Name")")
                  }
                }
                  .transition(.scale.combined(with: .opacity))
              }
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .transition(.scale.combined(with: .opacity))
        case .deviceSelected:
          Text("Device Selected \(deviceStore.selectedDevice?.name ?? ".none")")
          if let selectedDevice = deviceStore.selectedDevice as? ICCameraDevice {
            CameraItemsView(device: selectedDevice)
          }
        }
      }
    }
    .animation(.default, value: phase)
    .onAppear {
      checkPermission()
    }
    .onChange(of: phase) { oldValue, newValue in
      if newValue == .showDevices {
        if !deviceStore.isBrowsing {
          deviceStore.start()
        }
      } else {
        if deviceStore.isBrowsing {
          deviceStore.stop()
        }
      }
    }
    .onDisappear {
      if deviceStore.isBrowsing {
        deviceStore.stop()
      }
    }
  }

  @State var deviceStore: ImageCaptureCoreStore = .init()

  func checkPermission() {
    authorizationStatus = deviceStore.browser.contentsAuthorizationStatus
  }

  func requestPermission() {
    Task {
      authorizationStatus = await deviceStore.browser
        .requestContentsAuthorization()
    }
  }

  var transition: AnyTransition = .push(from: .trailing)
}

#Preview {
  SlidePreview {
    HowToUseSlide()
  }
}
