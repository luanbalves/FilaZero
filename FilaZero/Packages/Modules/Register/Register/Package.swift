// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let registerInterface = "RegisterInterface"
private let components = "Components"
private let authServiceInterface = "AuthServiceInterface"
private let dependencyContainer = "DependencyContainer"

let package = Package(
    name: "Register",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Register",
            targets: ["Register"]),
    ],
    dependencies: [
        .package(name: registerInterface, path: "../\(registerInterface)"),
        .package(name: components, path: "../../\(components)/\(components)"),
        .package(name: authServiceInterface, path: "../../../FirebaseServices/Auth/\(authServiceInterface)"),
        .package(name: dependencyContainer, path: "../../../\(dependencyContainer)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Register",
            dependencies: [
                .product(name: registerInterface, package: registerInterface),
                .product(name: components, package: components),
                .product(name: authServiceInterface, package: authServiceInterface),
                .product(name: dependencyContainer, package: dependencyContainer)
            ]
        ),
        .testTarget(
            name: "RegisterTests",
            dependencies: ["Register"]),
    ]
)
