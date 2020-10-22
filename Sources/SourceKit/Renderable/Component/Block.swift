import Foundation

extension Block {
    public enum Bracket {
        /// ()
        case round
        /// {}
        case curly
        /// []
        case square
        /// <>
        case angle

        fileprivate var open: String {
            switch self {
                case .round: return "("
                case .curly: return "{"
                case .square: return "["
                case .angle: return "<"
            }
        }

        fileprivate var close: String {
            switch self {
                case .round: return ")"
                case .curly: return "}"
                case .square: return "]"
                case .angle: return ">"
            }
        }
    }
}

open class Block: SourceRenderable {
    public let source: String

    public convenience init(_ head: String, bracket: Bracket, @SourceBuilder contents: ()->SourceRenderable) {
        self.init(head, open: bracket.open, close: bracket.close, contents: contents)
    }

    public convenience init(@SourceBuilder _ head: ()->String, bracket: Bracket, @SourceBuilder contents: ()->SourceRenderable) {
        self.init(head, open: bracket.open, close: bracket.close, contents: contents)
    }

    public init(@SourceBuilder _ head: ()->String, open: String = "{", close: String = "}", @SourceBuilder contents: ()->SourceRenderable) {
        source = "\(head())\(open)\n\(contents())\n\(close)"
    }

    public init(_ head: String, open: String = "{", close: String = "}", @SourceBuilder contents: ()->SourceRenderable) {
        source = "\(head)\(open)\n\(contents())\n\(close)"
    }
}

open class BlockComment: Block {
    public convenience init(@SourceBuilder _ contents: ()->SourceRenderable){
        self.init("", open: "/**", close: "**/", contents: contents)
    }
    public convenience init(_ comment: String){
        self.init("", open: "/**", close: "**/", contents: { comment })
    }
}

