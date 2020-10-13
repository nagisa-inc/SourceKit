import Foundation

public struct ForIn: SourceRenderable {
    public let source: String
    public init<Content>(_ items: [Content], separator: String = "\n", sort: Bool = true, @SourceBuilder provider: (Content) -> SourceRenderable) {
        source = items.map({
            provider($0).source
        }).sorted().joined(separator: separator)
    }
    public init<Content>(_ items: [Content], separator: String = "\n", sort: Bool = true, @SourceBuilder provider: (Content, Int) -> SourceRenderable) {
        source = items.enumerated().map({
            provider($0.element, $0.offset).source
        }).sorted().joined(separator: separator)
    }
}
