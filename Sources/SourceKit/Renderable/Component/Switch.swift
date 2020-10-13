import Foundation

public class Switch<Content: Equatable>: SourceRenderable {
    public private(set) var source: String = ""
    private let content: Content
    private var isFill: Bool = false

    public init(_ content: Content){
        self.content = content
    }

    public func `case`(_ value: Content, @SourceBuilder provider: () -> SourceRenderable) -> Switch {
        if value == content {
            self.source = provider().source
            self.isFill = true
        }
        return self
    }
    public func `default`(@SourceBuilder provider: () -> SourceRenderable) -> Switch {
        if !isFill {
            self.source = provider().source
        }
        return self
    }
}
