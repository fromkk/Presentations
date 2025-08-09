import Foundation
import ImageCaptureCore
import Observation
import OSLog

@Observable
final class ImageCaptureCoreStore: NSObject, ICDeviceBrowserDelegate,
  ICDeviceDelegate
{
  let browser: ICDeviceBrowser
  var devices: [ICDevice] = []
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: "ImageCaptureCoreStore"
  )

  override init() {
    self.browser = .init()
    super.init()
    self.browser.delegate = self
    self.devices = browser.devices ?? []
  }

  var selectedDevice: ICDevice?

  func select(_ device: ICDevice) {
    logger.info("\(#function) device \(device.description)")
    selectedDevice = device
    selectedDevice?.delegate = self
  }

  var files: [ICCameraItem] = []
  var error: (any Error)?

  func start() {
    logger.info("\(#function)")
    browser.start()
  }

  func stop() {
    logger.info("\(#function)")
    browser.stop()
  }

  var isBrowsing: Bool {
    logger.info("\(#function) browser.isBrowsing \(String(describing: self.browser.isBrowsing))")
    return browser.isBrowsing
  }

  // MARK: - ICDeviceBrowserDelegate

  func deviceBrowser(
    _ browser: ICDeviceBrowser,
    didAdd device: ICDevice,
    moreComing: Bool
  ) {
    logger.info("\(#function) device \(device.description)")
    devices.append(device)
  }

  func deviceBrowser(
    _ browser: ICDeviceBrowser,
    didRemove device: ICDevice,
    moreGoing: Bool
  ) {
    logger.info("\(#function) device \(device.description)")
    guard let index = devices.firstIndex(of: device) else {
      return
    }
    self.devices.remove(at: index)
  }

  // MARK: - ICDeviceDelegate

  func deviceDidBecomeReady(_ device: ICDevice) {
    logger.info("\(#function) device \(device.description)")
    guard let device = device as? ICCameraDevice else { return }
    files = device.mediaFiles ?? []
  }

  func didRemove(_ device: ICDevice) {
    logger.info("\(#function) device \(device.description)")
    selectedDevice = nil
  }

  func device(_ device: ICDevice, didOpenSessionWithError error: (any Error)?) {
    logger
      .info(
        "\(#function) device \(device.description) error \(String(describing: error))"
      )
    self.error = error
  }

  func device(
    _ device: ICDevice,
    didCloseSessionWithError error: (any Error)?
  ) {
    logger
      .info(
        "\(#function) device \(device.description) error \(String(describing: error))"
      )
    self.error = error
  }
}
