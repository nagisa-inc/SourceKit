import Foundation

public struct ForIn: SourceRenderable {
    public let source: String
    public init<Content>(_ items: [Content], separator: String = "\n", @SourceBuilder provider: (Content) -> String) {
        source = items.map({
            provider($0)
        }).joined(separator: separator)
    }
    public init<Content>(_ items: [Content], separator: String = "\n", @SourceBuilder provider: (Content, Int) -> String) {
        source = items.enumerated().map({
            provider($0.element, $0.offset)
        }).joined(separator: separator)
    }
}
