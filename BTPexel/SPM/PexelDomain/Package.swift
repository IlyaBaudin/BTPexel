// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PexelDomain",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PexelDomain",
            targets: ["PexelDomain"]),
    ],
    targets: [
        .target(
            name: "PexelDomain",
            path: "Sources/PexelDomain",
        ),
        .testTarget(
            name: "PexelDomainTests",
            dependencies: ["PexelDomain"],
            path: "Tests/PexelDomainTests"
        ),
    ]
)
