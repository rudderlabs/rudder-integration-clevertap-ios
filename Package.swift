// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rudder-CleverTap",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(
            name: "Rudder-CleverTap",
            targets: ["Rudder-CleverTap"]),
    ],
    dependencies: [
        .package(name: "clevertap-ios-sdk", url: "https://github.com/CleverTap/clevertap-ios-sdk.git", .exact("7.1.1")),
        .package(name: "Rudder", url: "https://github.com/rudderlabs/rudder-sdk-ios", "1.31.1"..<"2.0.0")
    ],
    targets: [
        .target(
            name: "Rudder-CleverTap",
            dependencies: [
                .product(name: "CleverTapSDK", package: "clevertap-ios-sdk"),
                .product(name: "Rudder", package: "Rudder"),
            ],
            path: "Rudder-CleverTap",
            sources: ["Classes/"],
            publicHeadersPath: "Classes/",
            cSettings: [
                .headerSearchPath("Classes/")
            ]
        )
    ]
)
