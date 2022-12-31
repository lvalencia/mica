// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "mica",
    dependencies: [
        .package(url: "https://github.com/mxcl/chalk.git", from: "0.5.0"),
        .package(url: "https://github.com/kylef/Commander.git", from: "0.9.2"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.3.0")
    ],
    targets: [
        .executableTarget(
            name: "mica",
            dependencies: [
                .product(name: "Chalk", package: "chalk"),
                .product(name: "Commander", package: "Commander"),
                .product(name: "ShellOut", package: "ShellOut"),
            ]
        ),
        .testTarget(
            name: "micaTests",
            dependencies: ["mica"]),
    ]
)
