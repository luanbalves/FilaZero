// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let firebaseAuth = "FirebaseAuth"
private let firebaseFirestore = "FirebaseFirestore"
private let firebaseIosSdk = "firebase-ios-sdk"
private let commonModels = "CommonModels"
private let authServiceInterface = "AuthServiceInterface"

let package = Package(
    name: "AuthServices",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AuthServices",
            targets: ["AuthServices"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.25.0"),
        .package(name: commonModels, path: "../../../\(commonModels)"),
        .package(name: authServiceInterface, path: "../\(authServiceInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AuthServices",
            dependencies: [
                .product(name: firebaseAuth, package: firebaseIosSdk),
                .product(name: firebaseFirestore, package: firebaseIosSdk),
                .product(name: commonModels, package: commonModels),
                .product(name: authServiceInterface, package: authServiceInterface)
            ]
        ),
        .testTarget(
            name: "AuthServicesTests",
            dependencies: ["AuthServices"]),
    ]
)
