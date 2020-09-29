import Foundation

extension Array: SourceRenderable where Element: SourceRenderable {
    public var source: String {
        map { (element) -> String in
            SourceBuilder.buildBlock(element)
        }.joined(separator: "\n")
    }
}

@_functionBuilder public struct SourceBuilder {
    private static func _buildBlock(_ buildables: [SourceRenderable]) -> String {
        buildables.map{ $0.source }.joined(separator: "\n")
    }

    public static func buildBlock() -> String { _buildBlock([]) }
    public static func buildBlock(_ buildables: SourceRenderable...) -> String { _buildBlock(buildables) }
    public static func buildBlock(_ buildable: SourceRenderable) -> String { _buildBlock([buildable])}
}

extension String: SourceRenderable {
    public var source: String { self }
}

extension Optional: SourceRenderable where Wrapped: SourceRenderable {
    @SourceBuilder
    public var source: String {
        self?.source ?? ""
    }
}
