import Foundation
import SourceKitLib
import XCAssetKit
import StringsFileKit

//: - Make engine
let directoryURL = URL(string: "file:///" + #file.split(separator: "/").dropLast().joined(separator: "/") + "/Generated")!
let engine = Engine(directoryURL)
//try engine.reset()

//: - (Optional) Set Delegate
class Delegate: EngineDelegate {
    func onStartRender(_ path: String) {
        print("start render \(path)")
    }
    func onFinishRender(_ path: String) {
        print("finish render \(path)")
    }
}
var delegate = Delegate()
engine.delegate = delegate

//: - Define file
struct File1: FileRenderable {
    var filepath: String { "File1.swift" }
    var reset: Bool { true }

    @SourceBuilder
    var source: String {
        "// This is File1"
    }
}

//: - Render file
try engine.render(File1())

//: - Template Samples
struct File2: FileRenderable {
    let b1: Bool = false
    let b2: Bool = false
    let optional: String? = "Optional"
    let array: [String] = ["String1", "String2", "String3", "String4", "String5"]
    enum Enum {
        case a
        case b
    }

    var filepath: String { "File2.swift" }

    @SourceBuilder
    var source: String {
        If(b1){
            "///If"
        }.elseIf(b2){
            "///If.elseIf"
        }.else {
            "///If.else"
        }

        If(optional){
            "/// \($0)"
        }

        ForIn(array){
            "/// Array: \($0)"
        }
        ForIn(array){
            "/// Array[\($1)]: \($0)"
        }

        Switch(Enum.a).case(.b){
            "/// Switch a"
        }.default {
            "/// Switch default"
        }

        BlockComment(){
            If(b1){
                """
                AAA
                """
            }
        }
    }
}
try engine.render(File2())

struct File3: StencilFileRenerable {
    var filepath: String { "File3.swift" }
    let name: String

    @SourceBuilder
    var template: String {
        """
        /// My name is {{ name }}
        """
    }
}

try engine.render(File3(name: "HogeHoge"))

//try engine.copy(url: URL(string: "file:///Users/trswkz/Work/Nagisa/SourceKit/Sources/SourceKit/Renderable/FileRenderable.swift")!, to: "Copy/FileRenderable.swift")

struct File4: FileRenderable {
    var filepath: String { "a.swift" }
    var subfiles: [FileRenderable] {
        [File1()]
    }
    var source: String { "" }
}

