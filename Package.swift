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
    static var rfc3986: Self { .product(name: "RFC 3986", package: "swift-rfc-3986") }
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
        .package(path: "../swift-rfc-3986")
    ],
    targets: [
        .target(
            name: .rss,
            dependencies: [.rfc3986]
        ),
        .target(
            name: .rssITunes,
            dependencies: [.rss]
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
