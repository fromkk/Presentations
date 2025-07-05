import WebKit
import SwiftUI
#if canImport(UIKit)
import UIKit

public struct BackportWebView: UIViewControllerRepresentable {
  var url: URL
  public init(url: URL) {
    self.url = url
  }

  public typealias UIViewControllerType = UIViewController

  public func makeUIViewController(context: Context) -> UIViewControllerType {
    let vc = UIViewController()
    let webView = WKWebView()
    webView
      .load(
        URLRequest(
          url: url,
          cachePolicy: .reloadIgnoringCacheData,
          timeoutInterval: 60
        )
      )
    webView.translatesAutoresizingMaskIntoConstraints = false
    vc.view.addSubview(webView)
    NSLayoutConstraint.activate([
      webView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
      vc.view.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
      webView.topAnchor.constraint(equalTo: vc.view.topAnchor),
      vc.view.bottomAnchor.constraint(equalTo: webView.bottomAnchor),
    ])

    return vc
  }

  public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    // nop
  }
}

#elseif canImport(AppKit)
import AppKit

public struct BackportWebView: NSViewControllerRepresentable {
  var url: URL
  public init(url: URL) {
    self.url = url
  }

  public typealias NSViewControllerType = NSViewController

  public func makeNSViewController(context: Context) -> NSViewControllerType {
    let vc = NSViewController()
    let webView = WKWebView()
    webView
      .load(
        URLRequest(
          url: url,
          cachePolicy: .reloadIgnoringCacheData,
          timeoutInterval: 60
        )
      )
    webView.translatesAutoresizingMaskIntoConstraints = false
    vc.view.addSubview(webView)
    NSLayoutConstraint.activate([
      webView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
      vc.view.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
      webView.topAnchor.constraint(equalTo: vc.view.topAnchor),
      vc.view.bottomAnchor.constraint(equalTo: webView.bottomAnchor),
    ])

    return vc
  }

  public func updateNSViewController(_ nsViewController: NSViewControllerType, context: Context) {
    // nop
  }
}

#endif

