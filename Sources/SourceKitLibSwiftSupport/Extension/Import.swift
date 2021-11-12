import SourceKitLib

public class Import: SourceRenderable {
    public var source: String
    public init(_ framework: String){
        self.source = "import \(framework)"
    }
}
