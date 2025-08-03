#if canImport(UIKit)
  @preconcurrency import AVFoundation
  import Combine
  import OSLog
  import SwiftUI
  import UIKit

  @MainActor
  protocol CameraViewControllerDelegate: AnyObject {
    func photoCaptured(_ data: Data)
    func captureFailed(_ error: any Error)
  }

  @MainActor
  final class CameraViewController: UIViewController, @preconcurrency
    AVCapturePhotoCaptureDelegate
  {
    private lazy var logger = Logger(
      subsystem: Bundle.main.bundleIdentifier!,
      category: "\(Self.self)"
    )

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
      logger.info("\(#function)")
      configuration()
      observeDeviceConnection()
    }

    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      logger.info("\(#function)")
      previewLayer?.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      logger.info("\(#function)")
      guard isConfigurationCompleted else { return }
      queue.async { [weak session] in
        guard let session, !session.isRunning else { return }
        session.startRunning()
      }
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      logger.info("\(#function)")
      guard isConfigurationCompleted else { return }
      queue.async { [weak session] in
        guard let session, session.isRunning else { return }
        session.stopRunning()
      }
    }

    var capturePhotoSettings: AVCapturePhotoSettings {
      guard let photoOutput = photoOutput else {
        return AVCapturePhotoSettings()
      }

      let settings: AVCapturePhotoSettings

      // Check available photo file types and use the first available one
      if photoOutput.availablePhotoFileTypes.contains(.heif) {
        settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
      } else if photoOutput.availablePhotoFileTypes.contains(.jpg) {
        settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
      } else {
        // Fallback to default settings
        settings = AVCapturePhotoSettings()
      }

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
      logger.info("\(#function)")
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
          Task { @MainActor in
            self.photoOutput = photoOutput
          }
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
          if let device = currentVideoInput?.device {
            self.createRotationCoordinator(for: device)
          }
          previewLayer.frame = self.view.bounds
          self.isConfigurationCompleted = true
        }
      }
    }

    private func observeDeviceConnection() {
      Task {
        for await _ in NotificationCenter.default.publisher(
          for: AVCaptureDevice.wasConnectedNotification
        ).values.map({ _ in () }) {
          if let device = deviceLookUp() {
            try? updateDeviceInput(device)
          }
        }
      }

      Task {
        for await _ in NotificationCenter.default.publisher(
          for: AVCaptureDevice.wasDisconnectedNotification
        ).values.map({ _ in () }) {
          if let device = deviceLookUp() {
            try? updateDeviceInput(device)
          }
        }
      }
    }

    var externalDeviceConnectedChanged: NSKeyValueObservation?

    nonisolated func deviceLookUp() -> AVCaptureDevice? {
      Task { await logger.info("deviceLookUp") }
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

    func updateDeviceInput(_ device: AVCaptureDevice) throws {
      logger.info("\(#function)")
      session.beginConfiguration()
      defer {
        session.commitConfiguration()
      }

      if let currentVideoInput {
        session.removeInput(currentVideoInput)
      }

      let deviceInput = try AVCaptureDeviceInput(device: device)
      if session.canAddInput(deviceInput) {
        session.addInput(deviceInput)
        currentVideoInput = deviceInput
      }
    }

    func takePhoto() {
      photoOutput?.capturePhoto(with: capturePhotoSettings, delegate: self)
    }

    var rotationCoordinator: AVCaptureDevice.RotationCoordinator?

    private var rotationCoordinatorPreviewObservation: NSKeyValueObservation?
    private var rotationCoordinatorOutputObservation: NSKeyValueObservation?

    private func createRotationCoordinator(for device: AVCaptureDevice) {
      let rotationCoordinator = AVCaptureDevice.RotationCoordinator(
        device: device,
        previewLayer: previewLayer
      )
      updatePreviewRotation(
        rotationCoordinator.videoRotationAngleForHorizonLevelPreview
      )
      updateOutputRotation(
        rotationCoordinator.videoRotationAngleForHorizonLevelCapture
      )

      rotationCoordinatorPreviewObservation?.invalidate()
      rotationCoordinatorPreviewObservation = rotationCoordinator.observe(
        \.videoRotationAngleForHorizonLevelPreview
      ) { [weak self] _, value in
        if let angle = value.newValue {
          Task { @MainActor in
            self?.updatePreviewRotation(angle)
          }
        }
      }

      rotationCoordinatorOutputObservation?.invalidate()
      rotationCoordinatorOutputObservation = rotationCoordinator.observe(
        \.videoRotationAngleForHorizonLevelCapture
      ) { [weak self] _, value in
        if let angle = value.newValue {
          Task { @MainActor in
            self?.updateOutputRotation(angle)
          }
        }
      }
    }

    private func updatePreviewRotation(_ angle: CGFloat) {
      previewLayer?.connection?.videoRotationAngle = angle
    }

    private func updateOutputRotation(_ angle: CGFloat) {
      photoOutput?.connection(with: .video)?.videoRotationAngle = angle
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

  struct CameraView: View {
    init(
      photoTaken: @escaping CameraCoordinator.PhotoTaken,
      captureFailed: @escaping CameraCoordinator.CaptureFailed
    ) {
      self.coordinator = CameraCoordinator(
        photoTaken: photoTaken,
        captureFailed: captureFailed
      )
    }

    let coordinator: CameraCoordinator

    var body: some View {
      ZStack {
        CameraViewRepresentable(coordinator: coordinator)

        VStack {
          Spacer()

          HStack {
            Spacer()

            Button(action: {
              coordinator.takePhoto()
            }) {
              Circle()
                .fill(Color.white)
                .frame(width: 90, height: 90)
                .overlay(
                  Circle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 80, height: 80)
                )
            }

            Spacer()
          }
          .padding(.bottom, 50)
        }
      }
    }
  }

  @MainActor @Observable
  final class CameraCoordinator: CameraViewControllerDelegate {
    typealias PhotoTaken = (Data) -> Void
    typealias CaptureFailed = (Error) -> Void

    var photoTaken: PhotoTaken
    var captureFailed: CaptureFailed

    init(
      photoTaken: @escaping PhotoTaken,
      captureFailed: @escaping CaptureFailed
    ) {
      self.photoTaken = photoTaken
      self.captureFailed = captureFailed
    }

    private let logger = Logger(
      subsystem: Bundle.main.bundleIdentifier!,
      category: "CameraCoordinator"
    )
    weak var cameraViewController: CameraViewController?

    func takePhoto() {
      cameraViewController?.takePhoto()
    }

    func photoCaptured(_ data: Data) {
      logger.info("\(#function) data \(data)")
      photoTaken(data)
    }

    func captureFailed(_ error: any Error) {
      logger.info("\(#function) error \(error)")
      captureFailed(error)
    }
  }

  struct CameraViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraViewController
    let coordinator: CameraCoordinator

    func makeUIViewController(context: Context) -> CameraViewController {
      let vc = UIViewControllerType()
      vc.delegate = coordinator
      return vc
    }

    func updateUIViewController(
      _ uiViewController: CameraViewController,
      context: Context
    ) {
      coordinator.cameraViewController = uiViewController
    }

    func makeCoordinator() -> CameraCoordinator {
      coordinator
    }
  }
#endif
