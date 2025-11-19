// swift-tools-version: 6.0

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
    static var standards: Self { .product(name: "Standards", package: "swift-standards") }
}

let package = Package(
    name: "swift-rss-standard",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11)
    ],
    products: [
        .library(name: .rss, targets: [.rss]),
        .library(name: .rssITunes, targets: [.rssITunes]),
        .library(name: .rssDublinCore, targets: [.rssDublinCore]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-uri-standard", from: "0.1.0"),
        .package(url: "https://github.com/swift-standards/swift-rfc-5322", from: "0.1.0"),
        .package(url: "https://github.com/swift-standards/swift-standards", from: "0.0.1")
    ],
    targets: [
        .target(
            name: .rss,
            dependencies: [.uriStandard, .rfc5322]
        ),
        .target(
            name: .rssITunes,
            dependencies: [.rss, .standards]
        ),
        .target(
            name: .rssDublinCore,
            dependencies: [.rss]
        ),
        .testTarget(
            name: .rss.tests,
            dependencies: [.rss, .rssITunes, .rssDublinCore]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }

for target in package.targets {
    target.swiftSettings?.append(
        contentsOf: [
            .enableUpcomingFeature("MemberImportVisibility")
        ]
    )
}
