import SlideKit
import SwiftUI

@Slide
public struct SelfIntroduce: View {
  @Environment(\.colorScheme) var colorScheme

  public init() {}
  public var body: some View {
    HStack(spacing: 32) {
      Code(
        """
        struct Profile {
          let name = "Kazuya Ueoka"
          let job = "iOS Developer"
          let x = "@fromkk"
          let github = "fromkk"
          let note = "fromkk"
          let basedOn = "Saitama, Japan"
          let favorite = "Photography"
        }
        """,
        syntaxHighlighter: colorScheme == .dark
          ? .presentationDark(fontSize: 60) : .presentation(fontSize: 60)
      )

      Image(.fromkk)
        .resizable()
        .frame(width: 300, height: 300)
    }
  }
}

#Preview {
  SlidePreview {
    SelfIntroduce()
  }
}
