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
