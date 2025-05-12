import SlideKit
import SwiftUI

@Slide
public struct SelfIntroduce: View {
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
        fontSize: 60
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
