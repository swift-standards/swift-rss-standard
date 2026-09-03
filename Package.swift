// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-rss-standard",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
    ],
    products: [
        .library(name: "RSS Standard", targets: ["RSS Standard"]),
        .library(name: "RSS Standard iTunes", targets: ["RSS Standard iTunes"]),
        .library(name: "RSS Standard Dublin Core", targets: ["RSS Standard Dublin Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-uri-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5322.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-standard-library-extensions.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-binary.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-radix-formatter.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "RSS Standard",
            dependencies: [
                .product(name: "URI Standard", package: "swift-uri-standard"), .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(name: "Parser", package: "swift-parser"),
            ]
        ),
        .target(
            name: "RSS Standard iTunes",
            dependencies: [.target(name: "RSS Standard"), .product(name: "Standard Library Extensions", package: "swift-standard-library-extensions"), .product(name: "Binary", package: "swift-binary"), .product(name: "Radix Formatter", package: "swift-radix-formatter")]
        ),
        .target(
            name: "RSS Standard Dublin Core",
            dependencies: [.target(name: "RSS Standard")]
        ),
        .testTarget(
            name: "RSS Standard Tests",
            dependencies: [.target(name: "RSS Standard"), .target(name: "RSS Standard iTunes"), .target(name: "RSS Standard Dublin Core")]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
