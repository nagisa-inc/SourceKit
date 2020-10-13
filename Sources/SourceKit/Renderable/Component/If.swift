import Foundation

public struct If: SourceRenderable {
    private let bool: Bool
    public fileprivate(set) var source: String = ""

    public init(_ bool: Bool, @SourceBuilder _ ifValue: () -> SourceRenderable) {
        self.bool = bool
        self.source = bool ? ifValue().source : ""
    }
    public init<Value>(_ value: Value?, @SourceBuilder _ ifValue: (Value) -> SourceRenderable) {
        if let value = value {
            self.bool = true
            self.source = ifValue(value).source
        } else {
            self.bool = false
            self.source = ""
        }
    }
}

public struct IfElse: SourceRenderable {
    public fileprivate(set) var source: String = ""
    public init(_ value: String){
        self.source = value
    }
}

extension If {
    public func `else`(@SourceBuilder _ elseValue: ()->SourceRenderable) -> IfElse {
        IfElse(bool ? source : elseValue().source)
    }
    public func `elseIf`(_ bool: Bool, @SourceBuilder _ elseValue: ()->SourceRenderable) -> If {
        if self.bool { return self }
        else { return If(bool, elseValue) }
    }
}
