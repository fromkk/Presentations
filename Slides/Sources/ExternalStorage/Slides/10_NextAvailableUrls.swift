#if !os(visionOS)

  import Common
  import SlideKit
  import SwiftUI

  @Slide
  struct NextAvailableUrls: View {
    @Phase var phase: SlidePhase

    enum SlidePhase: Int, Comparable, PhasedState {
      case initial
      case dcf
      case dcfSummary
    }

    let nextAvailableURL: URL = URL(
      string:
        "https://developer.apple.com/documentation/avfoundation/avexternalstoragedevice/nextavailableurls(withpathextensions:)"
    )!

    let dcfURL: URL = URL(
      string:
        "https://www.macvf.fr/softs/lemkesoft/graphicconverter/bibliotheque/docs/bibliographie/dcf1.0.pdf"
    )!

    var body: some View {
      Group {
        if phase == .initial {
          HeaderSlide("撮影した画像を保存する") {
            VStack(alignment: .leading) {
              Text("nextAvailableURLs(withPathExtensions:) で保存先を指定する")
              BackportWebView(url: nextAvailableURL)
              Text("\(nextAvailableURL)")
            }
          }
          .transition(.scale.combined(with: .opacity))
        } else if phase >= .dcf {
          HeaderSlide("DCF(Design rule for Camera File system)") {
            if phase == .dcf {
              VStack {
                BackportWebView(url: dcfURL)
                Text(dcfURL.absoluteString)
              }
              .transition(.scale.combined(with: .opacity))
            } else {
              ScrollView {
                VStack(alignment: .leading) {
                  Item("イメージ ルートディレクトリ: ルート直下に DCIM フォルダを作る")
                  Item("ディレクトリ名（DCIM 内）: 8文字") {
                    Item("前半3文字は 100～999 の数字（ディレクトリ番号）")
                    Item("後半5文字は大文字の英数字")
                  }
                  Item("ファイル名：拡張子除いて8文字") {
                    Item("前半4文字は大文字英数字")
                    Item("後半4文字は 0001～9999 の数字")
                  }
                  Item("同じファイル番号を持つファイル群が1つの “オブジェクト” にまとまる") {
                    Item("DCF basic file（拡張子 .JPG）")
                    Item("DCF extended image file（拡張子は .JPG または .THM 以外）")
                    Item("DCF thumbnail file（拡張子 .THM、extended image と同じ番号）")
                  }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              }
              .transition(.scale.combined(with: .opacity))
            }
          }
          .transition(.scale.combined(with: .opacity))
        }
      }

      .animation(.default, value: phase)
    }
    var transition: AnyTransition = .push(from: .trailing)
  }

  #Preview {
    SlidePreview {
      NextAvailableUrls()
    }
  }

#endif
