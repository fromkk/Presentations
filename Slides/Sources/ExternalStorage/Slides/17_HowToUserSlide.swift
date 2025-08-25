#if os(iOS)
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
      case percentCompleted
    }

    @State var authorizationStatus: ICAuthorizationStatus = .notDetermined
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
      HeaderSlide("How to use") {
        ScrollView {
          switch phase {
          case .initial:
            VStack(alignment: .leading) {
              Item("アクセス権限を取得")
              Code(
                """
                /// ユーザーにアクセスの許可を求める
                await ICDeviceBrowser().requestContentsAuthorization()
                """,
                syntaxHighlighter: colorScheme == .dark ? .presentationDark : .presentation
              )
              HStack(alignment: .top) {
                Code(
                  """
                    ICDeviceBrowser().contentsAuthorizationStatus = 
                  """, syntaxHighlighter: colorScheme == .dark ? .presentationDark : .presentation
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
            VStack(alignment: .leading, spacing: 16) {
              Code(
                """
                let browser = ICDeviceBrowser()
                browser.delegate = self // ICDeviceBrowserDelegate
                browser.start()
                browser.devices // [ICDevice]?
                """, syntaxHighlighter: colorScheme == .dark ? .presentationDark : .presentation
              )
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
            VStack(alignment: .leading) {
              Text(
                "Device Selected \(deviceStore.selectedDevice?.name ?? ".none")"
              )
              if let selectedDevice = deviceStore.selectedDevice
                as? ICCameraDevice
              {
                ContentCatalogPercentCompletedView(device: selectedDevice)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .transition(.scale.combined(with: .opacity))
          case .percentCompleted:
            VStack(alignment: .leading) {
              Text(
                "Device Selected \(deviceStore.selectedDevice?.name ?? ".none")"
              )
              if let selectedDevice = deviceStore.selectedDevice
                as? ICCameraDevice
              {
                CameraItemsView(device: selectedDevice)
              }
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

    var script: String {
      switch phase {
      case .initial:
        return """
        まずはアクセス権限を取得する必要があります。
        これはICDeviceBrowser().requestContentsAuthorization()というメソッドで取得することができます。
        取得した権限はICDeviceBrowser().contentsAuthorizationStatusプロパティで確認することができます。
        """
      case .showDevices:
        return """
        ICDeviceBrowserを利用することで接続しているデバイス一覧を確認することができます。
        start()/stop()で検索の開始・停止を実行します。
        devicesプロパティに接続済みのデバイス一覧が格納されています。
        接続イベントや接続解除イベントなどはdelegateを通じて受け取ることができます。
        """
      case .deviceSelected:
        return "ICCameraDeviceにはファイルやフォルダの情報が格納されています。"
      case .percentCompleted:
        return """
        ファイルの閲覧や削除などの操作が可能になっています。
        ここまで来れば独自ビューワーの作成も可能です。
        """
      }
    }
  }

  #Preview {
    SlidePreview {
      HowToUseSlide()
    }
  }
#endif
