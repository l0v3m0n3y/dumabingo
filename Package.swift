// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "worldstvmobile",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "worldstvmobile", targets: ["worldstvmobile"]),
    ],
    targets: [
        .target(
            name: "worldstvmobile",
            path: "src"
        ),
    ]
)