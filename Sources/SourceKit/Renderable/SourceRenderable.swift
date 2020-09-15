import Foundation

public protocol SourceRenderable {
    var source: String { get }
}

public struct Source: SourceRenderable {
    public let source: String
    public init(@SourceBuilder _ source: () -> String){
        self.source = source()
    }
}
