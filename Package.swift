// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "dumabingo",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "dumabingo", targets: ["dumabingo"]),
    ],
    targets: [
        .target(
            name: "dumabingo",
            path: "src"
        ),
    ]
)
