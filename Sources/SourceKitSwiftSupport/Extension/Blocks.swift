import SourceKit

public class Struct: Block {
    public init(_ name: String,
                acl: AccessControl = SourceKitSwiftConfig.shared.accessControl,
                protocols: [String],
                @SourceBuilder _ contents: ()->SourceRenderable ){
        let inherits = protocols.count == 0 ? "" : ": \(protocols.joined(separator: ","))"
        super.init("\(acl.rawValue) struct \(name) \(inherits)", contents: contents)
    }
}

public class Class: Block {
    public init(_ name: String,
                acl: AccessControl = SourceKitSwiftConfig.shared.accessControl,
                superClass: String? = nil,
                protocols: [String],
                @SourceBuilder _ contents: ()->SourceRenderable ){
        var inheritComponents = protocols
        if let superClass = superClass {
            inheritComponents.insert(superClass, at: 0)
        }
        let inherits = inheritComponents.count == 0 ? "" : ": \(inheritComponents.joined(separator: ","))"
        super.init("\(acl.rawValue) class \(name) \(inherits)", contents: contents)
    }
}

public class Enum: Block {
    public init(_ name: String,
                acl: AccessControl = SourceKitSwiftConfig.shared.accessControl,
                rawValue: String? = nil,
                protocols: [String],
                @SourceBuilder _ contents: ()->SourceRenderable ){
        var inheritComponents = protocols
        if let rawValue = rawValue {
            inheritComponents.insert(rawValue, at: 0)
        }
        let inherits = inheritComponents.count == 0 ? "" : ": \(inheritComponents.joined(separator: ","))"
        super.init("\(acl.rawValue) enum \(name) \(inherits)", contents: contents)
    }
}

public class Extension: Block {
    public init(_ name: String,
                acl: AccessControl = SourceKitSwiftConfig.shared.accessControl,
                protocols: [String],
                @SourceBuilder _ contents: ()->SourceRenderable ){
        let inherits = protocols.count == 0 ? "" : ": \(protocols.joined(separator: ","))"
        super.init("\(acl.rawValue) extension \(name) \(inherits)", contents: contents)
    }
}
