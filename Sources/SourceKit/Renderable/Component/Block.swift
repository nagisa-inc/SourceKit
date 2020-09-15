import Foundation

public struct Block: SourceRenderable {
    public let source: String

    public init(@SourceBuilder _ head: ()->String, @SourceBuilder contents: ()->String) {
        source = "\(head()){\n\(contents())\n}"
    }

    public init(_ head: String, @SourceBuilder contents: ()->String) {
        source = "\(head){\n\(contents())\n}"
    }
}
