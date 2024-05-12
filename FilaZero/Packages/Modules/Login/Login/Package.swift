// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let registerInterface = "RegisterInterface"
private let components = "Components"
private let dependencyContainer = "DependencyContainer"
private let loginInterface = "LoginInterface"
private let authServiceInterface = "AuthServiceInterface"

let package = Package(
    name: "Login",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Login",
            targets: ["Login"]),
    ],
    dependencies: [
        .package(name: registerInterface, path: "../../Register/\(registerInterface)"),
        .package(name: components, path: "../../\(components)/\(components)"),
        .package(name: dependencyContainer, path: "../../../\(dependencyContainer)"),
        .package(name: loginInterface, path: "../\(loginInterface)"),
        .package(name: authServiceInterface, path: "../../../FirebaseServices/Auth/\(authServiceInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Login",
        dependencies: [
            .product(name: registerInterface, package: registerInterface),
            .product(name: components, package: components),
            .product(name: dependencyContainer, package: dependencyContainer),
            .product(name: loginInterface, package: loginInterface),
            .product(name: authServiceInterface, package: authServiceInterface)
        ]
        ),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]),
    ]
)
