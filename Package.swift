// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-graphics",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "Graphics", targets: ["Graphics"]),
        .library(name: "PlatformGraphics", targets: ["PlatformGraphics"]),
        .library(name: "CairoGraphics", targets: ["CairoGraphics"]),
        .library(name: "CoreGraphicsGraphics", targets: ["CoreGraphicsGraphics"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0"),
        .package(url: "https://github.com/fwcd/swift-utils.git", from: "3.0.7"),
        .package(url: "https://github.com/fwcd/swift-cairo.git", from: "1.3.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Graphics",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Utils", package: "swift-utils"),
                .product(name: "Cairo", package: "swift-cairo"),
            ]
        ),
        .target(
            name: "CairoGraphics",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Utils", package: "swift-utils"),
                .product(name: "Cairo", package: "swift-cairo"),
                .target(name: "Graphics"),
            ]
        ),
        .target(
            name: "CoreGraphicsGraphics",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Utils", package: "swift-utils"),
                .target(name: "Graphics"),
            ]
        ),
        .target(
            name: "PlatformGraphics",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Utils", package: "swift-utils"),
                .target(name: "CairoGraphics", condition: .when(platforms: [.android, .windows, .linux])),
                .target(name: "CoreGraphicsGraphics", condition: .when(platforms: [.iOS, .macOS, .macCatalyst, .tvOS, .watchOS])),
            ]
        ),
        .testTarget(
            name: "GraphicsTests",
            dependencies: [
                .target(name: "Graphics"),
            ]
        )
    ]
)
