import Foundation

public class Block: SourceRenderable {
    public let source: String

    public init(@SourceBuilder _ head: ()->String, open: String = "{", close: String = "}", @SourceBuilder contents: ()->SourceRenderable) {
        source = "\(head())\(open)\n\(contents())\n\(close)"
    }

    public init(_ head: String, open: String = "{", close: String = "}", @SourceBuilder contents: ()->SourceRenderable) {
        source = "\(head)\(open)\n\(contents())\n\(close)"
    }
}

public class BlockComment: Block {
    public convenience init(@SourceBuilder _ contents: ()->String){
        self.init("", open: "/**", close: "**/", contents: contents)
    }
    public convenience init(_ comment: String){
        self.init("", open: "/**", close: "**/", contents: comment)
    }
}
