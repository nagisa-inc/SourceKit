import Foundation

public class Block: SourceRenderable {
    public let source: String

    public init(@SourceBuilder _ head: ()->String, open: String = "{", close: String = "}", @SourceBuilder contents: ()->String) {
        source = "\(head())\(open)\n\(contents())\n\(close)"
    }

    public init(_ head: String, open: String = "{", close: String = "}", @SourceBuilder contents: ()->String) {
        source = "\(head)\(open)\n\(contents())\n\(close)"
    }
}

public class BlockComment: Block {
    public override init(_ head: String, open: String = "/** ", close: String = "**/", contents: () -> String) {
        super.init(head, open: open, close: close, contents: contents)
    }
}
