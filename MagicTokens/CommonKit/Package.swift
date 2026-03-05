// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CommonKit",
            targets: ["CommonKit"]
        ),
        .library(
            name: "CommonKitTestSources",
            targets: ["CommonKitTestSources"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.63.2")
    ],
    targets: [
        .target(
            name: "CommonKit",
            dependencies: [],
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
        ),
        .target(
            name: "CommonKitTestSources",
            dependencies: ["CommonKit"],
            path: "TestSources",
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
        ),
        .testTarget(
            name: "CommonKitTests",
            dependencies: ["CommonKit"],
            path: "Tests",
            plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
        )
    ]
)
