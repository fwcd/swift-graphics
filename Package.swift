// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-graphics",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Graphics",
            targets: ["Graphics"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0"),
        .package(url: "https://github.com/fwcd/swift-utils.git", from: "1.1.0"),
        .package(url: "https://github.com/fwcd/swift-cairo.git", from: "1.3.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Graphics",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Utils", package: "swift-utils"),
                .product(name: "Cairo", package: "swift-cairo")
            ]
        ),
        .testTarget(
            name: "GraphicsTests",
            dependencies: ["Graphics"]
        )
    ]
)
