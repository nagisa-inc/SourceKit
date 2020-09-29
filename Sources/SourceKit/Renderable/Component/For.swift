import Foundation

public struct ForIn: SourceRenderable {
    public let source: String
    public init<Content>(_ items: [Content], separator: String = "\n", sort: Bool = true, @SourceBuilder provider: (Content) -> String) {
        source = items.map({
            provider($0)
        }).sorted().joined(separator: separator)
    }
    public init<Content>(_ items: [Content], separator: String = "\n", sort: Bool = true, @SourceBuilder provider: (Content, Int) -> String) {
        source = items.enumerated().map({
            provider($0.element, $0.offset)
        }).sorted().joined(separator: separator)
    }
}
