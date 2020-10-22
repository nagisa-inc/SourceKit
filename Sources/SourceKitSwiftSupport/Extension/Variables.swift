import Foundation
import SourceKit

public protocol RHSConnectable: class, SourceRenderable {
    var source: String { get set }
}

extension RHSConnectable {
    public func set(@SourceBuilder _ contents: ()->SourceRenderable) -> Self {
        self.source += "= \(contents().source)"
        return self
    }
    public func set(_ contents: String) -> Self{
        self.source += "= \(contents)"
        return self
    }
}

extension RHSConnectable {
    public func getter(@SourceBuilder _ contents: ()->SourceRenderable) -> Self {
        self.source += Block { contents().source }.source
        return self
    }
    public func getter(_ contents: String) -> Self{
        self.source += Block { contents }.source
        return self
    }
}

public class Variable: RHSConnectable {
    public var source: String
    public init(_ name: String, acl: AccessControl = SourceKitSwiftConfig.shared.accessControl, type: String, optional: Bool){
        self.source = "\(acl.rawValue) var \(name): \(type)"
    }
}
public class StaticVariable: RHSConnectable {
    public var source: String
    public init(_ name: String, acl: AccessControl = SourceKitSwiftConfig.shared.accessControl, type: String, optional: Bool){
        self.source = "\(acl.rawValue) static var \(name): \(type)"
    }
}

public class Constant: RHSConnectable {
    public var source: String
    public init(_ name: String, acl: AccessControl = SourceKitSwiftConfig.shared.accessControl, type: String, optional: Bool){
        self.source = "\(acl.rawValue) let \(name): \(type)"
    }
}
public class StaticConstant: RHSConnectable {
    public var source: String
    public init(_ name: String, acl: AccessControl = SourceKitSwiftConfig.shared.accessControl, type: String, optional: Bool){
        self.source = "\(acl.rawValue) static let \(name): \(type)"
    }
}

