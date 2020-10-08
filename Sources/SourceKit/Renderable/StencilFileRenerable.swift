import Foundation
import Stencil

public protocol StencilFileRenerable: FileRenderable {
    var template: String { get }
    var filters: [StencilFilter] { get }
}

extension StencilFileRenerable {
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


extension StencilFileRenerable {
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
