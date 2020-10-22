import Foundation

public struct Member {
    public let name: String
    public let type: String
    public let optional: Bool
    public let defaultValue: String?

    public init(_ name: String, type: String, optional: Bool, defaultValue: String?){
        self.name = name
        self.type = type
        self.optional = optional
        self.defaultValue = defaultValue
    }
}
