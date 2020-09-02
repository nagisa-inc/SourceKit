import Foundation

public struct FileRenderOption: OptionSet {
    public let rawValue: UInt
    public init(rawValue: UInt){
        self.rawValue = rawValue
    }

    public static let compress = FileRenderOption(rawValue: 1 << 0)
    public static let format = FileRenderOption(rawValue: 1 << 1)

    public static let `default`: FileRenderOption = [.compress, .format]
}

public protocol FileRenderable: SourceRenderable {
    var filepath: String { get }
    var options: FileRenderOption { get }
    var subfiles: [FileRenderable] { get }
}

extension FileRenderable {
    public var options: FileRenderOption { .default }
    public var subfiles: [FileRenderable] { [] }
}

public struct File: FileRenderable {
    public let filepath: String
    public let options: FileRenderOption
    public let subfiles: [FileRenderable]
    public let source: String

    public init(filepath: String, options: FileRenderOption = .default, subfiles: [FileRenderable] = [],
                @SourceBuilder source: () -> String){
        self.filepath = filepath
        self.options = options
        self.subfiles = subfiles
        self.source = source()
    }
}
