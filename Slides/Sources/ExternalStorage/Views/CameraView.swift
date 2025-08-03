@preconcurrency import AVFoundation
import SwiftUI
import UIKit

protocol CameraViewControllerDelegate: AnyObject {
  func photoCaptured(_ data: Data)
  func captureFailed(_ error: any Error)
}

@MainActor
final class CameraViewController: UIViewController, @preconcurrency
  AVCapturePhotoCaptureDelegate
{
  weak var delegate: CameraViewControllerDelegate?
  let session = AVCaptureSession()
  var currentVideoInput: AVCaptureDeviceInput?
  var photoOutput: AVCapturePhotoOutput?
  private let queue = DispatchQueue(
    label: "\(Bundle.main.bundleIdentifier!).CameraViewController",
    qos: .default
  )
  var previewLayer: AVCaptureVideoPreviewLayer?
  var isConfigurationCompleted: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    configuration()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    previewLayer?.frame = view.bounds
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard isConfigurationCompleted else { return }
    queue.async { [weak session] in
      guard let session, !session.isRunning else { return }
      session.startRunning()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    guard isConfigurationCompleted else { return }
    queue.async { [weak session] in
      guard let session, session.isRunning else { return }
      session.stopRunning()
    }
  }

  var capturePhotoSettings: AVCapturePhotoSettings {
    let settings = AVCapturePhotoSettings(format: [
      AVVideoCodecKey: AVVideoCodecType.hevc
    ])

    var meta: [String: Any] = [:]
    meta[kCGImagePropertyTIFFSoftware as String] =
      Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
      ?? "Presentations"
    settings.metadata["{TIFF}"] = meta

    // Add EXIF orientation metadata
    var exifDict: [String: Any] = [:]
    //    let orientation = exifOrientation(for: currentOrientation ?? .portrait)
    //    exifDict[kCGImagePropertyOrientation as String] = orientation
    settings.metadata[kCGImagePropertyExifDictionary as String] = exifDict

    return settings
  }

  func configuration() {
    queue.async { [weak self, weak session] in
      guard let self, let session else { return }

      session.beginConfiguration()

      if let device = self.deviceLookUp(),
        let deviceInput = try? AVCaptureDeviceInput(device: device),
        session.canAddInput(deviceInput)
      {
        session.addInput(deviceInput)
        Task { @MainActor in
          self.currentVideoInput = deviceInput
        }
      }

      let photoOutput = AVCapturePhotoOutput()
      if session.canAddOutput(photoOutput) {
        session.addOutput(photoOutput)
      }
      Task { @MainActor in
        self.photoOutput = photoOutput
      }

      if session.canSetSessionPreset(.photo) {
        session.sessionPreset = .photo
      }

      let previewLayer = AVCaptureVideoPreviewLayer(session: session)
      previewLayer.videoGravity = .resizeAspect
      Task { @MainActor in
        self.previewLayer = previewLayer
      }

      session.commitConfiguration()

      session.startRunning()

      Task { @MainActor in
        self.view.layer.addSublayer(previewLayer)
        previewLayer.frame = self.view.bounds
        self.isConfigurationCompleted = true
      }
    }
  }

  nonisolated func deviceLookUp() -> AVCaptureDevice? {
    let externalCameraDiscoverySession = AVCaptureDevice.DiscoverySession(
      deviceTypes: [.external],
      mediaType: .video,
      position: .unspecified
    )
    if let externalCamera = externalCameraDiscoverySession.devices.first {
      return externalCamera
    }

    let backCameraDiscoverySession = AVCaptureDevice.DiscoverySession(
      deviceTypes: [
        .builtInWideAngleCamera,
        .builtInUltraWideCamera,
        .builtInTelephotoCamera,
      ],
      mediaType: .video,
      position: .back
    )
    if let backCamera = backCameraDiscoverySession.devices.first {
      return backCamera
    }

    let frontVideoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(
      deviceTypes: [.builtInWideAngleCamera],
      mediaType: .video,
      position: .front
    )
    if let frontCamera = frontVideoDeviceDiscoverySession.devices.first {
      return frontCamera
    }

    return nil
  }

  func takePhoto() {
    photoOutput?.capturePhoto(with: capturePhotoSettings, delegate: self)
  }

  // MARK: - AVCapturePhotoCaptureDelegate

  func photoOutput(
    _ output: AVCapturePhotoOutput,
    didFinishProcessingPhoto photo: AVCapturePhoto,
    error: (any Error)?
  ) {
    if let error {
      delegate?.captureFailed(error)
    } else if let data = photo.fileDataRepresentation() {
      delegate?.photoCaptured(data)
    }
  }
}

struct CameraView: UIViewControllerRepresentable {
  typealias UIViewControllerType = CameraViewController
  func makeUIViewController(context: Context) -> CameraViewController {
    let vc = UIViewControllerType()
    vc.delegate = context.coordinator
    return vc
  }

  func updateUIViewController(
    _ uiViewController: CameraViewController,
    context: Context
  ) {
    // nop
  }

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  final class Coordinator: CameraViewControllerDelegate {
    func photoCaptured(_ data: Data) {

    }

    func captureFailed(_ error: any Error) {

    }
  }
}
