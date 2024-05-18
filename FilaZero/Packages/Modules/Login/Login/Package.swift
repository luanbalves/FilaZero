// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let registerInterface = "RegisterInterface"
private let components = "Components"
private let dependencyContainer = "DependencyContainer"
private let loginInterface = "LoginInterface"
private let authServiceInterface = "AuthServiceInterface"
private let homeInterface = "HomeInterface"
private let profileInterface = "ProfileInterface"
private let ordersInterface = "OrdersInterface"

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
        .package(name: authServiceInterface, path: "../../../FirebaseServices/Auth/\(authServiceInterface)"),
        .package(name: homeInterface, path: "../../Home/\(homeInterface)"),
        .package(name: profileInterface, path: "../../Profile/\(profileInterface)"),
        .package(name: ordersInterface, path: "../../Orders/\(ordersInterface)")
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
            .product(name: authServiceInterface, package: authServiceInterface),
            .product(name: homeInterface, package: homeInterface),
            .product(name: profileInterface, package: profileInterface),
            .product(name: ordersInterface, package: ordersInterface)
        ]
        ),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]),
    ]
)
