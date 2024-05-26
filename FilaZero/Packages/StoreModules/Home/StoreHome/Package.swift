// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let StoreHomeInterface = "StoreHomeInterface"
private let storeServicesInterface = "StoreServicesInterface"
private let dependencyContainer = "DependencyContainer"
private let kingFisher = "Kingfisher"
private let commonModels = "CommonModels"
let package = Package(
    name: "StoreHome",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StoreHome",
            targets: ["StoreHome"]),
    ],
    dependencies: [
        .package(name: StoreHomeInterface, path: "../\(StoreHomeInterface)"),
        .package(name: storeServicesInterface, path: "../../../FirebaseServices/Store/\(storeServicesInterface)"),
        .package(name: dependencyContainer, path: "../../../\(dependencyContainer)"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.11.0"),
        .package(name: commonModels, path: "../../../\(commonModels)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StoreHome",
            dependencies: [
                .product(name: StoreHomeInterface, package: StoreHomeInterface),
                .product(name: storeServicesInterface, package: storeServicesInterface),
                .product(name: dependencyContainer, package: dependencyContainer),
                .product(name: kingFisher, package: kingFisher),
                .product(name: commonModels, package: commonModels)
            ]
        ),
        .testTarget(
            name: "StoreHomeTests",
            dependencies: ["StoreHome"]),
    ]
)
