// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SourceKit",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "SourceKit", targets: ["SourceKit"]),
        .executable(name: "SourceKitPlayground", targets: ["SourceKit", "SourceKitPlayground"])
    ],
    dependencies: [
        .package(url: "https://github.com/stencilproject/Stencil.git", from: Version(0, 13, 0)),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.44.13"),
        .package(url: "https://github.com/yonaskolb/SwagGen.git", from: "4.3.0"),
    ],
    targets: [
        .target(
            name: "SourceKit",
            dependencies: ["Stencil", "SwiftFormat"],
            exclude: ["SourceKit/Template/Source.swift"]),
        .target(name: "SourceKitPlayground", dependencies: ["SourceKit"], exclude: ["SourceKitPlayground/Generated"]),
    ]
)
