// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let profileInterface = "ProfileInterface"
let package = Package(
    name: "Profile",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Profile",
            targets: ["Profile"]),
    ],
    dependencies: [
        .package(name: profileInterface, path: "../\(profileInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Profile",
            dependencies: [
                .product(name: profileInterface, package: profileInterface)
            ]
        ),
        .testTarget(
            name: "ProfileTests",
            dependencies: ["Profile"]),
    ]
)
