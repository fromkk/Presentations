import CoreImage
import Foundation

extension Data {
  var splitImages: (CGImage, CGImage)? {
    guard let src = CGImageSourceCreateWithData(self as CFData, nil) else {
      return nil
    }

    guard
      let properties = CGImageSourceCopyProperties(src, nil)
        as? [CFString: Any],
      let groups = properties[kCGImagePropertyGroups] as? [[CFString: Any]],
      let stereoPairGroup = groups.first(where: {
        $0[kCGImagePropertyGroupType] as? String
          == (kCGImagePropertyGroupTypeStereoPair as String)
      }),
      let leftIndex = stereoPairGroup[kCGImagePropertyGroupImageIndexLeft]
        as? Int,
      let rightIndex = stereoPairGroup[kCGImagePropertyGroupImageIndexRight]
        as? Int,
      let left = CGImageSourceCreateImageAtIndex(src, leftIndex, nil),
      let right = CGImageSourceCreateImageAtIndex(src, rightIndex, nil)
    else {
      return nil
    }
    return (left, right)
  }

  var orientation: CGImagePropertyOrientation? {
    guard
      let src = CGImageSourceCreateWithData(self as CFData, nil),
      let property = CGImageSourceCopyProperties(src, nil) as? [CFString: Any],
      let rawValue = property[kCGImagePropertyOrientation] as? UInt32
    else {
      return nil
    }
    return CGImagePropertyOrientation(rawValue: rawValue)
  }
}
