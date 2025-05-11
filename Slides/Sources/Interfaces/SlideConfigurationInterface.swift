import SlideKit
import SwiftUI

@MainActor
public protocol SlideConfigurationInterface: SlideConfigurationHashable {
  var title: String { get }

  var size: CGSize { get }

  var slideIndexController: SlideIndexController { get }

  var theme: any SlideTheme { get }
}

public protocol SlideConfigurationHashable: Identifiable, Hashable {
  var id: String { get }
}

extension SlideConfigurationHashable {
  public var hashValue: Int {
    id.hashValue
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id.hashValue)
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
}
