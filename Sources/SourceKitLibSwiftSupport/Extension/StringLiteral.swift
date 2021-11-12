import Foundation
import SourceKitLib

public struct StringLiteral: SourceRenderable {
    public var source: String
    public init(_ value: String){
        if value.contains("\n") || value.contains("\"") {
            source =
                #"""
                """
                \#(value)
                """
                """#
        } else {
            source = "\"\(value)\""
        }
    }
}
