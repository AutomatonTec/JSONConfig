// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONConfig",
    products: [
        .library(
            name: "JSONConfig",
            targets: ["JSONConfig"]),
    ],
    dependencies: [
        .package(url: "https://github.com/PerfectlySoft/PerfectLib.git", "3.0.0"..<"4.0.0"),
    ],
    targets: [
        .target(
            name: "JSONConfig",
            dependencies: ["PerfectLib"]),
    ]
)
