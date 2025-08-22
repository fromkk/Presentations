import SlideKit
import SwiftUI
import UniformTypeIdentifiers

struct ExportFileDocument: FileDocument {
  static let readableContentTypes: [UTType] = [.jpeg]

  init(configuration: ReadConfiguration) throws {
    fatalError("not implemented")
  }

  let fileExporter: @Sendable () throws -> URL
  init(_ fileExporter: @escaping @Sendable () throws -> URL) {
    self.fileExporter = fileExporter
  }

  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    let url = try fileExporter()
    return try FileWrapper(url: url, options: .immediate)
  }

  enum ExportError: Error {
    case fileExportFailed
  }
}

@Slide
struct FileExporterSlide: View {
  @State var isFileExporterPresented: Bool = false
  @State var photoData: Data?
  @State var error: (any Error)?

  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    HeaderSlide(".fileExporter") {
      if photoData == nil {
        CameraView { data in
          photoData = data
        } captureFailed: { error in
          self.error = error
        }
      } else {
        ScrollView {
          Code(
            #"""
            struct ExportFileDocument: FileDocument {
              static let readableContentTypes: [UTType] = [.jpeg]
              init(configuration: ReadConfiguration) throws {
                fatalError("not implemented")
              }

              let fileExporter: @Sendable () throws -> URL
              init(_ fileExporter: @escaping @Sendable () throws -> URL) {
                self.fileExporter = fileExporter
              }

              func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
                let url = try fileExporter()
                return try FileWrapper(url: url, options: .immediate)
              }

              enum ExportError: Error {
                case fileExportFailed
              }
            }

            .fileExporter(
              isPresented: $isFileExporterPresented,
              document: ExportFileDocument {
                guard let photoData else { throw ExportDocument.ExportError.fileExportFailed }
                let fileManager = FileManager.default
                let url = fileManager.temporaryDirectory.appending(path: "\(UUID().uuidString).jpg")
                try photoData.write(to: url)
                return url
              }, contentType: .jpeg) { result in
                if let url = try? result.get() {
                  try? FileManager.default.removeItem(at: url)
                }
              }
            """#,
            syntaxHighlighter: colorScheme == .dark
              ? .presentationDark : .presentation
          )
        }

        Button {
          isFileExporterPresented = true
        } label: {
          Text(".fileExporter")
        }
        .buttonStyle(.borderedProminent)
      }
    }
    .alert(
      "\(String(describing: error?.localizedDescription))",
      isPresented: Binding(
        get: {
          error != nil
        },
        set: {
          if !$0 { error = nil }
        }
      ),
      actions: {
        Button(action: {}, label: { Text("OK") })
      }
    )
    .fileExporter(
      isPresented: $isFileExporterPresented,
      document: ExportFileDocument {
        guard let photoData else {
          throw ExportFileDocument.ExportError.fileExportFailed
        }
        let fileManager = FileManager.default
        let url = fileManager.temporaryDirectory.appending(
          path: "\(UUID().uuidString).jpg"
        )
        try photoData.write(to: url)
        return url
      },
      contentType: .jpeg
    ) { result in
      if let url = try? result.get() {
        try? FileManager.default.removeItem(at: url)
      }
    }
  }

  var transition: AnyTransition = .push(from: .trailing)

  var script: String {
    if photoData == nil {
      return """
        ここでは .fileExporter modifier の使い方を見てみます。最初に保存するデータを用意します。
        """
    } else {
      return """
        データが用意できたら View に対して .fileExporter を指定します。
        Temporary領域などにファイルを保存して、URLを返せばファイルの保存が可能です。
        しかし、これだとユーザーにディレクトリを選んでもらう必要があります。
        """
    }
  }
}
