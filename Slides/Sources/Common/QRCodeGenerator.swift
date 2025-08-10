import CoreImage

#if canImport(UIKit)
  import UIKit
  public typealias PlatformColor = UIColor
#elseif canImport(AppKit)
  import AppKit
  public typealias PlatformColor = NSColor
#endif

public struct QRCodeGenerator: Sendable {
  public init() {}

  public func callAsFunction(_ input: String, tintColor: PlatformColor = .black)
    -> CIImage?
  {
    guard let data = input.data(using: .utf8) else {
      return nil
    }
    return image(from: data)?.tinted(using: tintColor)
  }

  func callAsFunction(_ input: Data, tintColor: PlatformColor = .black)
    -> CIImage?
  {
    return image(from: input)?.tinted(using: tintColor)
  }

  func image(from data: Data) -> CIImage? {
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
    qrFilter.setValue(data, forKey: "inputMessage")
    qrFilter.setValue("H", forKey: "inputCorrectionLevel")
    let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
    return qrFilter.outputImage?.transformed(by: qrTransform)
  }
}

extension CIImage {
  /// Inverts the colors and creates a transparent image by converting the mask to alpha.
  /// Input image should be black and white.
  public var transparent: CIImage? {
    inverted?.blackTransparent
  }

  /// Inverts the colors.
  public var inverted: CIImage? {
    guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else {
      return nil
    }

    invertedColorFilter.setValue(self, forKey: "inputImage")
    return invertedColorFilter.outputImage
  }

  /// Converts all black to transparent.
  public var blackTransparent: CIImage? {
    guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else {
      return nil
    }
    blackTransparentFilter.setValue(self, forKey: "inputImage")
    return blackTransparentFilter.outputImage
  }

  /// Applies the given color as a tint color.
  func tinted(using color: PlatformColor) -> CIImage? {
    guard
      let transparentQRImage = transparent,
      let filter = CIFilter(name: "CIMultiplyCompositing"),
      let colorFilter = CIFilter(name: "CIConstantColorGenerator")
    else { return nil }

    let ciColor = CIColor(color: color)
    colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
    let colorImage = colorFilter.outputImage

    filter.setValue(colorImage, forKey: kCIInputImageKey)
    filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)

    return filter.outputImage
  }
}
