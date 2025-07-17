import SlideKit
import SwiftUI

struct AcceptedView: View {
  var body: some View {
    Text("採択")
      .font(.system(size: 300, weight: .semibold))
      .foregroundStyle(.white)
      .padding(EdgeInsets(top: 32, leading: 64, bottom: 32, trailing: 64))
      .background(Color(.accepted))
      .clipShape(RoundedRectangle(cornerRadius: 64))
  }
}

#Preview {
  AcceptedView()
}
