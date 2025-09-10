#if os(iOS)

  import SlideKit
  import SwiftUI
  import UniformTypeIdentifiers
  import PhotosUI

  struct ImportFileDocument: FileDocument {
    static let readableContentTypes: [UTType] = [.jpeg, .png, .image]

    var data: Data?

    init(configuration: ReadConfiguration) throws {
      if let fileWrapper = configuration.file.regularFileContents {
        self.data = fileWrapper
      } else {
        throw ImportError.fileImportFailed
      }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
      guard let data else { throw ImportError.fileImportFailed }
      return FileWrapper(regularFileWithContents: data)
    }

    enum ImportError: Error {
      case fileImportFailed
    }
  }

  @Slide
  struct FileImporterSlide: View {
    @State var isFileImporterPresented: Bool = false
    @State var importedImageData: Data?
    @State var error: (any Error)?

    @Environment(\.colorScheme) var colorScheme

    @Phase var phase: SlidePhase

    enum SlidePhase: Int, PhasedState {
      case initial
      case second
      case third
    }

    var body: some View {
      HeaderSlide(".fileImporter") {
        switch phase {
        case .initial:
          VStack(spacing: 20) {
            Text("外部ストレージからファイルをインポート")
              .font(.title2)

            Button {
              isFileImporterPresented = true
            } label: {
              Text("ファイルを選択")
            }
            .buttonStyle(.borderedProminent)

            if let importedImageData,
              let uiImage = UIImage(data: importedImageData)
            {
              Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300, maxHeight: 200)
                .cornerRadius(10)
            }
          }
        case .second:
          ScrollView {
            Code(
              #"""
              .fileImporter(
                isPresented: $isFileImporterPresented,
                allowedContentTypes: [.jpeg, .png, .image]
              ) { result in
                switch result {
                case .success(let url):
                  guard url.startAccessingSecurityScopedResource() else {
                    return
                  }
                  defer {
                    url.stopAccessingSecurityScopedResource()
                  }
                  do {
                    let data = try Data(contentsOf: url)
                    importedImageData = data
                  } catch {
                    self.error = error
                  }
                case .failure(let error):
                  self.error = error
                }
              }

              struct ImportFileDocument: FileDocument {
                static let readableContentTypes: [UTType] = [.jpeg, .png, .image]
                var data: Data?
                init(configuration: ReadConfiguration) throws {
                  if let fileWrapper = configuration.file.regularFileContents {
                    self.data = fileWrapper
                  } else {
                    throw ImportError.fileImportFailed
                  }
                }

                func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
                  guard let data else { throw ImportError.fileImportFailed }
                  return FileWrapper(regularFileWithContents: data)
                }

                enum ImportError: Error {
                  case fileImportFailed
                }
              }
              """#,
              syntaxHighlighter: colorScheme == .dark
                ? .presentationDark : .presentation
            )
          }
        case .third:
          Item(".fileImporter を使うことで外部ストレージからファイルを選択可能")
          Item("ユーザーがファイルを選択するとURLが取得できる")
          Item("外部ストレージのファイルにアクセスできるが、ユーザーの操作が必要")
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
      .fileImporter(
        isPresented: $isFileImporterPresented,
        allowedContentTypes: [.jpeg, .png, .image]
      ) { result in
        switch result {
        case .success(let url):
          guard url.startAccessingSecurityScopedResource() else {
            return
          }
          defer {
            url.stopAccessingSecurityScopedResource()
          }
          do {
            let data = try Data(contentsOf: url)
            importedImageData = data
          } catch {
            self.error = error
          }
        case .failure(let error):
          self.error = error
        }
      }
    }

    var transition: AnyTransition = .push(from: .trailing)

    var script: String {
      switch phase {
      case .initial:
        return """
          .fileImporter modifier を使って外部ストレージからファイルをインポートしてみます。
          """
      case .second:
        return """
          .fileImporter を使うことで、ユーザーがファイルを選択できるようになります。
          選択されたファイルのURLが取得でき、そのデータを読み込むことができます。
          """
      case .third:
        return """
          .fileImporter は外部ストレージからのファイル選択に便利です。
          しかし、これもユーザーの操作が必要で、特定のディレクトリのファイルを表示するという用途には向いていません。
          """
      }
    }
  }
#endif
