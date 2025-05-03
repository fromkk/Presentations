import SlideKit
import SwiftUI

@MainActor
public protocol SlideConfigurationInterface: Identifiable {
  var id: String { get }

  var size: CGSize { get }

  var slideIndexController: SlideIndexController { get }

  var theme: any SlideTheme { get }
}
