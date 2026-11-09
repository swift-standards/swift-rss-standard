// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-rss-standard",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "RSS Standard", targets: ["RSS Standard"]),
        .library(name: "RSS Standard iTunes", targets: ["RSS Standard iTunes"]),
        .library(name: "RSS Standard Dublin Core", targets: ["RSS Standard Dublin Core"]),
        .library(name: "RSS Standard XML", targets: ["RSS Standard XML"]),
        .library(
            name: "RSS Standard Foundation Integration",
            targets: ["RSS Standard Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-uri-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5322.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5646.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-domain-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-w3c/swift-w3c-xml.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "RSS Standard",
            dependencies: [
                .product(name: "Domain Standard", package: "swift-domain-standard"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 5646", package: "swift-rfc-5646"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
            ]
        ),
        .target(
            name: "RSS Standard iTunes",
            dependencies: [
                .target(name: "RSS Standard"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
            ]
        ),
        .target(
            name: "RSS Standard Dublin Core",
            dependencies: [
                .target(name: "RSS Standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(name: "RFC 5646", package: "swift-rfc-5646"),
            ]
        ),
        .target(
            name: "RSS Standard Foundation Integration",
            dependencies: [
                .target(name: "RSS Standard"),
                .target(name: "RSS Standard iTunes"),
                .target(name: "RSS Standard Dublin Core"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "Domain Standard", package: "swift-domain-standard"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(name: "RFC 5646", package: "swift-rfc-5646"),
                .product(
                    name: "RFC 3986 Foundation Integration",
                    package: "swift-rfc-3986"
                ),
                .product(
                    name: "RFC 5322 Foundation Integration",
                    package: "swift-rfc-5322"
                ),
            ]
        ),
        .target(
            name: "RSS Standard XML",
            dependencies: [
                .target(name: "RSS Standard"),
                .product(name: "W3C XML", package: "swift-w3c-xml"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "Domain Standard", package: "swift-domain-standard"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(name: "RFC 5646", package: "swift-rfc-5646"),
            ]
        ),
        .testTarget(
            name: "RSS Standard XML Tests",
            dependencies: [
                .target(name: "RSS Standard"),
                .target(name: "RSS Standard XML"),
                .product(name: "W3C XML", package: "swift-w3c-xml"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
            ]
        ),
        .testTarget(
            name: "RSS Standard Tests",
            dependencies: [
                .target(name: "RSS Standard"),
                .target(name: "RSS Standard iTunes"),
                .target(name: "RSS Standard Dublin Core"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(name: "RFC 5646", package: "swift-rfc-5646"),
            ]
        ),
        .testTarget(
            name: "RSS Standard Foundation Integration Tests",
            dependencies: [
                .target(name: "RSS Standard"),
                .target(name: "RSS Standard iTunes"),
                .target(name: "RSS Standard Dublin Core"),
                .target(name: "RSS Standard Foundation Integration"),
                .product(name: "URI Standard", package: "swift-uri-standard"),
                .product(name: "Domain Standard", package: "swift-domain-standard"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(name: "RFC 5646", package: "swift-rfc-5646"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableExperimentalFeature("Lifetimes"),
            .treatAllWarnings(as: .error),
        ]
}
