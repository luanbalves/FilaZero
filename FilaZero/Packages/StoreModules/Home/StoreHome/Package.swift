// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let StoreHomeInterface = "StoreHomeInterface"
let package = Package(
    name: "StoreHome",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StoreHome",
            targets: ["StoreHome"]),
    ],
    dependencies: [
        .package(name: StoreHomeInterface, path: "../\(StoreHomeInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StoreHome",
            dependencies: [
                .product(name: StoreHomeInterface, package: StoreHomeInterface)
            ]
        ),
        .testTarget(
            name: "StoreHomeTests",
            dependencies: ["StoreHome"]),
    ]
)
