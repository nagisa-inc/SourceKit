import Foundation
import Stencil
import SwiftFormat

public protocol EngineDelegate: class {
    func onStartRender(_ path: String)
    func onFinishRender(_ path: String)
}

public class Engine {
    public let destinationDirectory: URL
    public weak var delegate: EngineDelegate?
    public init(_ destinationDirectory: URL){
        self.destinationDirectory = destinationDirectory
    }

    public func render(_ file: FileRenderable) throws {
        let filepath = destinationDirectory.appendingPathComponent(file.filepath)
        let dirpath = filepath.path.components(separatedBy: "/").dropLast().joined(separator: "/")
        delegate?.onStartRender(filepath.path)

        if file.reset && FileManager.default.fileExists(atPath: filepath.path) {
            try FileManager.default.removeItem(at: filepath)
        }

        let body = try parse(file)
        let compressed = file.options.contains(.compress) ? compress(body) : body
        let formatted = file.options.contains(.format) ? try SwiftFormat.format(compressed) : compressed
        if !FileManager.default.fileExists(atPath: dirpath) {
            try FileManager.default.createDirectory(atPath: dirpath, withIntermediateDirectories: true, attributes: nil)
        }
        FileManager.default.createFile(atPath: filepath.path, contents: formatted.data(using: .utf8), attributes: nil)
        delegate?.onFinishRender(filepath.path)

        try file.subfiles.forEach { (file) in
            try render(file)
        }
    }

    public func parse(_ template: SourceRenderable) throws -> String {
        if let template = template as? StencilSourceRenderable & Template {
            return try template.render()
        } else {
            return template.source
        }
    }
}

private extension Engine {
    func compress(_ value: String) -> String {
        return value.components(separatedBy: .newlines).compactMap {
            $0.trimmingCharacters(in: .whitespaces).count == 0 ? nil : $0
        }.joined(separator: "\n")
    }
}

public extension Engine {
    /// Remove destination directory
    /// - Throws:
    func reset() throws {
        if FileManager.default.fileExists(atPath: destinationDirectory.path) {
            try FileManager.default.removeItem(atPath: destinationDirectory.path)
        }
    }
}

public extension Engine {
    func copy(url: URL, to destination: String) throws {
        let dest = destinationDirectory.appendingPathComponent(destination)
        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) {
            let dirpath = dest.path.components(separatedBy: "/").dropLast().joined(separator: "/")
            if !FileManager.default.fileExists(atPath: dirpath) {
                try FileManager.default.createDirectory(atPath: dirpath, withIntermediateDirectories: true, attributes: nil)
            }
            try? FileManager.default.removeItem(atPath: dest.path)
            try FileManager.default.copyItem(atPath: url.path, toPath: dest.path)
        }
    }
}
