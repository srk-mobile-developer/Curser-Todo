// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TodoApp",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "TodoApp",
            targets: ["TodoApp"]
        ),
    ],
    targets: [
        .target(
            name: "TodoApp",
            dependencies: []
        ),
    ]
)