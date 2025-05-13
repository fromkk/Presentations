import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .fontWeight(.semibold)
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(isEnabled ? Color.accentColor : Color.gray)
      .foregroundStyle(Color.white)
      .clipShape(Capsule())
  }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
  static var primaryButtonStyle: Self { Self() }
}
