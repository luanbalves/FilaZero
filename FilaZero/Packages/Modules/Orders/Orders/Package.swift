// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let ordersInterface = "OrdersInterface"
let package = Package(
    name: "Orders",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Orders",
            targets: ["Orders"]),
    ],
    dependencies: [
        .package(name: ordersInterface, path: "../\(ordersInterface)")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Orders",
            dependencies: [
                .product(name: ordersInterface, package: ordersInterface)
            ]
        ),
        .testTarget(
            name: "OrdersTests",
            dependencies: ["Orders"]),
    ]
)
