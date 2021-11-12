// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SourceKitLib",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "SourceKitLib", targets: ["SourceKitLib"]),
        .library(name: "SourceKitLibSwiftSupport", targets: ["SourceKitLibSwiftSupport"]),
        .library(name: "XCAssetKit", targets: ["XCAssetKit"]),
        .library(name: "StringsFileKit", targets: ["StringsFileKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.14.2"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.44.13"),
    ],
    targets: [
        .target(
            name: "SourceKitLib",
            dependencies: ["Stencil", "SwiftFormat"],
            exclude: []),
        .target(
            name: "SourceKitLibSwiftSupport",
            dependencies: ["SourceKitLib"]
        ),
        .target(name: "XCAssetKit"),
        .target(name: "StringsFileKit")
    ]
)
