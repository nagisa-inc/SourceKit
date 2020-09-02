import Foundation

public struct ForIn: SourceRenderable {
    public let source: String
    public init<Content>(_ items: [Content], @SourceBuilder provider: (Content) -> String) {
        source = items.map({
            provider($0)
        }).joined(separator: "\n")
    }
    public init<Content>(_ items: [Content], @SourceBuilder provider: (Content, Int) -> String) {
        source = items.enumerated().map({
            provider($0.element, $0.offset)
        }).joined(separator: "\n")
    }
}
