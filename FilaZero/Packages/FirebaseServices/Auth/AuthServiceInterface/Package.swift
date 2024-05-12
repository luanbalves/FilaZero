// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let commonModels = "CommonModels"
private let firebaseAuth = "FirebaseAuth"
private let firebaseIosSdk = "firebase-ios-sdk"

let package = Package(
    name: "AuthServiceInterface",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AuthServiceInterface",
            targets: ["AuthServiceInterface"]),
    ],
    dependencies: [
        .package(name: commonModels, path: "../../../\(commonModels)"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.25.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AuthServiceInterface",
            dependencies: [
                .product(name: commonModels, package: commonModels),
                .product(name: firebaseAuth, package: firebaseIosSdk)
            ]),
        .testTarget(
            name: "AuthServiceInterfaceTests",
            dependencies: ["AuthServiceInterface"]),
    ]
)
