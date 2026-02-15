// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AegisMVP",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "AegisMVP", targets: ["AegisMVP"])
    ],
    targets: [
        .target(
            name: "AegisMVP",
            path: "AegisMVP",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
