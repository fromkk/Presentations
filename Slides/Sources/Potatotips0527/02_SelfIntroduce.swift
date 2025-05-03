import SlideKit
import SwiftUI

@Slide
struct SelfIntroduce: View {
  var body: some View {
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
      fontSize: 80
    )
  }
}

#Preview {
  SlidePreview {
    SelfIntroduce()
  }
}
