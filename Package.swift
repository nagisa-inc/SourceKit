// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SourceKit",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "SourceKit", targets: ["SourceKit"]),
        .library(name: "SourceKitSwiftSupport", targets: ["SourceKitSwiftSupport"]),
        .library(name: "XCAssetKit", targets: ["XCAssetKit"]),
        .library(name: "StringsFileKit", targets: ["StringsFileKit"]),
        .executable(name: "SourceKitPlayground", targets: ["SourceKit", "XCAssetKit", "SourceKitPlayground"])
    ],
    dependencies: [
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.14.2"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.44.13"),
    ],
    targets: [
        .target(
            name: "SourceKit",
            dependencies: ["Stencil", "SwiftFormat"],
            exclude: ["SourceKit/Template/Source.swift"]),
        .target(
            name: "SourceKitSwiftSupport",
            dependencies: ["SourceKit"]
        ),
        .target(name: "XCAssetKit"),
        .target(name: "StringsFileKit"),
        
        .target(name: "SourceKitPlayground",
                dependencies: ["SourceKit", "XCAssetKit", "StringsFileKit"],
                exclude: ["SourceKitPlayground/Generated"])
    ]
)
