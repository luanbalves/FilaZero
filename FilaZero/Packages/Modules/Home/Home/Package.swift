// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let authServiceInterface = "AuthServiceInterface"
private let homeInterface = "HomeInterface"
private let storeServicesInterface = "StoreServicesInterface"
private let dependencyContainer = "DependencyContainer"
private let commonModels = "CommonModels"
private let kingFisher = "Kingfisher"

let package = Package(
    name: "Home",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(name: authServiceInterface, path: "../../../FirebaseServices/Auth/\(authServiceInterface)"),
        .package(name: homeInterface, path: "../\(homeInterface)"),
        .package(name: storeServicesInterface, path: "../../../FirebaseServices/Store/\(storeServicesInterface)"),
        .package(name: dependencyContainer, path: "../../../\(dependencyContainer)"),
        .package(name: commonModels, path: "../../../\(commonModels)"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.11.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Home",
            dependencies: [
                .product(name: authServiceInterface, package: authServiceInterface),
                .product(name: homeInterface, package: homeInterface),
                .product(name: storeServicesInterface, package: storeServicesInterface),
                .product(name: dependencyContainer, package: dependencyContainer),
                .product(name: commonModels, package: commonModels),
                .product(name: kingFisher, package: kingFisher)
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
    ]
)
