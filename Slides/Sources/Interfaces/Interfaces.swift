import SlideKit
import SwiftUI

@MainActor
public protocol SlideConfigurationInterface {
  var size: CGSize { get }

  var slideIndexController: SlideIndexController { get }

  var theme: any SlideTheme { get }
}
