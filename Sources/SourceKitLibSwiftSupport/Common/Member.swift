import Foundation

public struct Member {
    public let name: String
    public let type: String
    public let optional: Bool
    public let defaultValue: String?
    public let defaultNil: Bool

    public init(_ name: String, type: String, optional: Bool = false, defaultValue: String? = nil, defaultNil: Bool = true){
        self.name = name
        self.type = type
        self.optional = optional
        self.defaultValue = defaultValue
        self.defaultNil = defaultNil
    }
}
