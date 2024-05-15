// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let authServiceInterface = "AuthServiceInterface"
private let homeInterface = "HomeInterface"
let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(name: authServiceInterface, path: "../../../FirebaseServices/Auth/\(authServiceInterface)"),
        .package(name: homeInterface, path: "../\(homeInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Home",
            dependencies: [
                .product(name: authServiceInterface, package: authServiceInterface),
                .product(name: homeInterface, package: homeInterface)
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
    ]
)
