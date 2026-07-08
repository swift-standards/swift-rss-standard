// swift-tools-version: 6.3.1

import PackageDescription

extension String {
    static let rss: Self = "RSS Standard"
    static let rssITunes: Self = "RSS Standard iTunes"
    static let rssDublinCore: Self = "RSS Standard Dublin Core"
}

extension Target.Dependency {
    static var rss: Self { .target(name: .rss) }
    static var rssITunes: Self { .target(name: .rssITunes) }
    static var rssDublinCore: Self { .target(name: .rssDublinCore) }
    static var uriStandard: Self { .product(name: "URI Standard", package: "swift-uri-standard") }
    static var rfc5322: Self { .product(name: "RFC 5322", package: "swift-rfc-5322") }
    static var standards: Self { .product(name: "Standard Library Extensions", package: "swift-standard-library-extensions") }
    static var binary: Self { .product(name: "Binary Primitives", package: "swift-binary-primitives") }
    static var radixFormatter: Self { .product(name: "Radix Formatter Primitives", package: "swift-radix-formatter-primitives") }
}

let package = Package(
    name: "swift-rss-standard",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(name: "RSS Standard", targets: ["RSS Standard"]),
        .library(name: "RSS Standard iTunes", targets: ["RSS Standard iTunes"]),
        .library(name: "RSS Standard Dublin Core", targets: ["RSS Standard Dublin Core"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-uri-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5322.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-standard-library-extensions.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-binary-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-parser-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-radix-formatter-primitives.git", branch: "main")
    ],
    targets: [
        .target(
            name: "RSS Standard",
            dependencies: [.uriStandard, .rfc5322, .product(name: "Parser Primitives", package: "swift-parser-primitives")]
        ),
        .target(
            name: "RSS Standard iTunes",
            dependencies: [.rss, .standards, .binary, .radixFormatter]
        ),
        .target(
            name: "RSS Standard Dublin Core",
            dependencies: [.rss]
        ),
        .testTarget(
            name: "RSS Standard Tests",
            dependencies: [.rss, .rssITunes, .rssDublinCore]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
    var foundation: Self { self + " Foundation" }
}

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
