import SourceKit

public class Func: SourceRenderable {
    public let source: String
    public init(_ name: String,
                acl: AccessControl = SourceKitSwiftConfig.shared.accessControl,
                members: [Member] = [],
                return: String? = nil,
                @SourceBuilder _ body: ()->SourceRenderable){
        self.source = Block({
            Block("\(acl.rawValue) func \(name)", bracket: .round){
                ForIn(members, separator: ","){ member in
                    var result = "\(member.name): \(member.type)\(member.optional ? "?" : "")"
                    if member.optional && member.defaultNil {
                        result += "= nil"
                    } else if let defaultValue = member.defaultValue {
                        result += "= \(defaultValue)"
                    }
                    return result
                }
            }
            If(`return`){ returnType in
                "-> \(returnType)"
            }
        }){
            body()
        }.source
    }
}

public class StaticFunc: SourceRenderable {
    public let source: String
    public init(_ name: String,
                acl: AccessControl = SourceKitSwiftConfig.shared.accessControl,
                members: [Member] = [],
                return: String? = nil,
                @SourceBuilder _ body: ()->SourceRenderable){
        self.source = Block({
            Block("\(acl.rawValue) static func \(name)", bracket: .round){
                ForIn(members, separator: ","){ member in
                    var result = "\(member.name): \(member.type)\(member.optional ? "?" : "")"
                    if member.optional && member.defaultNil {
                        result += "= nil"
                    } else if let defaultValue = member.defaultValue {
                        result += "= \(defaultValue)"
                    }
                    return result
                }
            }
            If(`return`){ returnType in
                "-> \(returnType)"
            }
        }){
            body()
        }.source
    }
}

public class Init: SourceRenderable {
    public let source: String
    public init(acl: AccessControl = SourceKitSwiftConfig.shared.accessControl,
                members: [Member] = [],
                autoset: Bool = false,
                @SourceBuilder _ body: ()->SourceRenderable = { "" }){
        self.source = Block({
            Block("\(acl.rawValue) init", bracket: .round){
                ForIn(members, separator: ","){ member in
                    var result = "\(member.name): \(member.type)\(member.optional ? "?" : "")"
                    if member.optional && member.defaultNil {
                        result += "= nil"
                    } else if let defaultValue = member.defaultValue {
                        result += "= \(defaultValue)"
                    }
                    return result
                }
            }
        }){
            If(autoset){
                ForIn(members){ member in
                    """
                    self.\(member.name) = \(member.name)
                    """
                }
            }
            body()
        }.source
    }
}
