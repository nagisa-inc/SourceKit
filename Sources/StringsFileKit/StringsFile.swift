import Foundation

private let fileManager = FileManager.default
internal extension FileManager {
    func isDirectory(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        if fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        }
        return false
    }
}

public enum StringsFileKitError: Error {
    case couldNotLocateFile
}


public struct StringsFile {
    public var dictionary: [String: String]
    public var keyValues: [(key: String, value: String)] {
        dictionary.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.key.compare(rhs.key) == .orderedAscending
        })
    }
    public var keys: [String] { keyValues.map({ $0.key }) }
    public func value(for key: String) -> String? { dictionary[key] }

    public init(_ path: String) throws {
        guard fileManager.fileExists(atPath: path), let dic = NSDictionary(contentsOfFile: path) else {
            throw StringsFileKitError.couldNotLocateFile
        }
        var data: [String: String] = [:]
        for body in dic {
            guard let key = body.key as? String, let value = body.value as? String else {
                continue
            }
            data[key] = value
        }
        self.dictionary = data
    }
}
