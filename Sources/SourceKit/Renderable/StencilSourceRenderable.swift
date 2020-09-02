import Foundation
import Stencil

public struct StencilFilter {
    public let name: String
    public let operation: (Any, [Any]) -> Any

    public init(_ name: String, operation: @escaping (Any, [Any]) -> Any) {
        self.name = name
        self.operation = operation
    }
}

public protocol StencilSourceRenderable: SourceRenderable {
    var template: String { get }
    var filters: [StencilFilter] { get }
}

extension StencilSourceRenderable {
    public var filters: [StencilFilter] {[]}
    public var keyValueMap: [String: Any] {
        let mirror = Mirror(reflecting: self)
        var description: [String: Any] = [:]
        for case let (label?, value) in mirror.children {
            description[label] = value
        }
        return description
    }
}
extension StencilSourceRenderable {
    public var source: String {
        do {
            return try render()
        } catch {
            fatalError()
        }
    }
    public func render() throws -> String {
        let ext = Extension()
        filters.forEach {
            ext.registerFilter($0)
        }
        var env = Environment()
        env.extensions = [ext]
        let context = keyValueMap
        return try env.renderTemplate(string: template, context: context)
    }
}

extension Stencil.Extension {
    public func registerFilter(_ filter: StencilFilter){
        registerFilter(filter.name, filter: filter.operation)
    }
}
