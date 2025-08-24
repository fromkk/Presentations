#if os(iOS)

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

    @Phase var phase: SlidePhase

    enum SlidePhase: Int, PhasedState {
      case initial
      case second
      case third
    }

    var body: some View {
      HeaderSlide(".fileExporter") {
        switch phase {
        case .initial:
          CameraView { data in
            photoData = data
            $phase.forward()
          } captureFailed: { error in
            self.error = error
          }
        case .second:
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
        case .third:
          Item("最低限の挙動は問題ない。")
          Item("しかし、ユーザーにエクスポートするディレクトリを選んでもらう必要がある。")
          Item("実現したいのはユーザーがディレクトリを選ぶことなく外部ストレージへのエクスポート")
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
      switch phase {
      case .initial:
        return """
          .fileExporter modifier を使ってみます。最初に保存するデータを用意します。
          """
      case .second:
        return """
          データが用意できたら View に対して .fileExporter を指定します。
          Temporary領域などにファイルを保存して、URLを返せばファイルの保存が可能です。
          """
      case .third:
        return """
          最低限の挙動としてはこれで問題ありません。
          しかし、これだとユーザーにディレクトリを選んでもらう必要があります。
          実現したいのはユーザーがディレクトリを選ぶことなく外部ストレージへファイルをエクスポートすることです。
          """
      }
    }
  }
#endif
