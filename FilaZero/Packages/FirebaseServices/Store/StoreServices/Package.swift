// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let firebaseAuth = "FirebaseAuth"
private let firebaseFirestore = "FirebaseFirestore"
private let firebaseIosSdk = "firebase-ios-sdk"
private let commonModels = "CommonModels"
private let utilities = "Utilities"
private let storeServicesInterface = "StoreServicesInterface"

let package = Package(
    name: "StoreServices",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StoreServices",
            targets: ["StoreServices"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.25.0"),
        .package(name: commonModels, path: "../../../\(commonModels)"),
        .package(name: utilities, path: "../../../\(utilities)"),
        .package(name: storeServicesInterface, path: "../\(storeServicesInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StoreServices",
            dependencies: [
                .product(name: firebaseAuth, package: firebaseIosSdk),
                .product(name: firebaseFirestore, package: firebaseIosSdk),
                .product(name: commonModels, package: commonModels),
                .product(name: utilities, package: utilities),
                .product(name: storeServicesInterface, package: storeServicesInterface)
            ]
        ),
        .testTarget(
            name: "StoreServicesTests",
            dependencies: ["StoreServices"]),
    ]
)
