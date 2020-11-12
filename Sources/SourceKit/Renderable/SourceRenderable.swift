import Foundation

public protocol SourceRenderable {
    var source: String { get }
}

public struct Source: SourceRenderable {
    public let source: String
    public init(@SourceBuilder _ source: () -> SourceRenderable){
        self.source = source().source
    }
}

public struct FatalError: SourceRenderable {
    public let message: String
    public init(_ message: String = ""){
        self.message = message
    }

    public var source: String { fatalError(message) }
}
