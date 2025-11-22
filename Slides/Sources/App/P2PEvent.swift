import Foundation

struct P2PEvent: Hashable, Codable, CustomStringConvertible {
  enum Name: String, Codable {
    case slideSelected
    case scriptChanged
    case indexChanged
    case backSlide
    case forwardSlide
    case finished
  }

  let eventName: Name
  let eventValue: String

  var description: String {
    "\(Self.self) eventName: \(eventName), eventValue: \(eventValue)"
  }
}
