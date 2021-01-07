// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CatNewsCore",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],

    products: [
        .library(
            name: "CatNewsCore",
            targets: ["CatNewsCore"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.0.0"))
    ],

    targets: [
        .target(
            name: "CatNewsCore",
            dependencies: ["RxSwift"]
        ),
        .testTarget(
            name: "CatNewsCoreTests",
            dependencies: ["CatNewsCore", "RxSwift"],
            resources: [
                .copy("MockData")
            ]
        )
    ]
)
