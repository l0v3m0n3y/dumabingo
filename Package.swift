let package = Package(
    name: "dumabingo",
    products: [
        .library(name: "dumabingo", targets: ["dumabingo"])
    ],
    targets: [
        .target(name: "dumabingo", path: "src")
    ]
)
