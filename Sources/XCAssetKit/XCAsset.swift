import Foundation

private let fileManager = FileManager.default
private let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    return decoder
}()

public enum XCAssetKitError: Error {
    case invalidRoot
    case fileNotFound(String)
    case unimplementedFormat

    case invalidImage
    case invalidDirectory
    case invalidColor
}

internal extension FileManager {
    func isDirectory(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        if fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        }
        return false
    }
}

public struct XCAsset {
    var info: XCAssetInfo
    var items: [XCAssetItem]

    public init(_ path: String) throws {
        guard fileManager.isDirectory(atPath: path) else {
            throw XCAssetKitError.invalidRoot
        }

        let jsonPath = "\(path)/Contents.json"
        guard let data = fileManager.contents(atPath: jsonPath) else{
            throw XCAssetKitError.invalidRoot
        }
        let content = try jsonDecoder.decode(XCAssetInfo.self, from: data)
        self.info = content

        items = try fileManager.contentsOfDirectory(atPath: path)
            .compactMap({ (subPath) -> XCAssetItem? in
                let nextPath = "\(path)/\(subPath)"
                if fileManager.isDirectory(atPath: nextPath) {
                    return try XCAssetItem(nextPath)
                } else {
                    return nil
                }
            })
    }
}

public enum XCAssetItem {
    case directory(Directory)
    case image(Image)
    case color(Color)

    init(_ path: String) throws {
        guard fileManager.isDirectory(atPath: path) else {
            throw XCAssetKitError.fileNotFound(path)
        }
        if path.hasSuffix(".imageset") {
            self = .image(try Image(path: path))
        } else if path.hasSuffix(".colorset") {
            self = .color(try Color(path: path))
        } else {
            self = .directory(try Directory(path: path))
        }
    }

    public struct Image {
        public let name: String

        init(path: String) throws {
            guard let name = path.split(separator: "/").last?.replacingOccurrences(of: ".imageset", with: "") else {
                throw XCAssetKitError.invalidImage
            }
            self.name = name
        }
    }
    public struct Directory {
        public let name: String
        public let providesNameSpace: Bool
        public let items: [XCAssetItem]

        init(path: String) throws {
            guard let name = path.split(separator: "/").last else {
                throw XCAssetKitError.invalidDirectory
            }
            let jsonPath = "\(path)/Contents.json"
            guard let data = fileManager.contents(atPath: jsonPath) else {
                throw XCAssetKitError.invalidDirectory
            }
            let content = try jsonDecoder.decode(XCAssetInfo.self, from: data)
            guard let providesNameSpace = content.properties?.providesNamespace else {
                throw XCAssetKitError.invalidDirectory
            }
            self.providesNameSpace = providesNameSpace
            self.name = String(name)

            self.items = try fileManager.contentsOfDirectory(atPath: path)
                .compactMap({ (subPath) -> XCAssetItem? in
                    let nextPath = "\(path)/\(subPath)"
                    if fileManager.isDirectory(atPath: nextPath) {
                        return try XCAssetItem(nextPath)
                    } else {
                        return nil
                    }
                })
        }
    }
    public struct Color {
        public let name: String

        init(path: String) throws {
            guard let name = path.split(separator: "/").last?.replacingOccurrences(of: ".colorset", with: "") else {
                throw XCAssetKitError.invalidDirectory
            }
            self.name = String(name)
        }
    }
}

struct XCAssetInfo: Codable {
    struct Info: Codable {
        let version: Int
        let author: String
    }

    struct Properties: Codable {
        let providesNamespace: Bool?

        enum CodingKeys: String, CodingKey {
            case providesNamespace = "provides-namespace"
        }
    }

    struct Image: Codable {
        let filename: String
        let idiom: String
    }

    let info: Info
    let properties: Properties?
    let images: [Image]?
}
