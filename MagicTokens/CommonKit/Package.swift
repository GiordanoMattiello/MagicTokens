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
        ),
    ],
    targets: [
        .target(
            name: "CommonKit"
        ),
        .target(
            name: "CommonKitTestSources",
            dependencies: ["CommonKit"],
            path: "TestSources"
        ),
        .testTarget(
            name: "CommonKitTests",
            dependencies: ["CommonKit"],
            path: "Tests"
        ),
    ]
)
