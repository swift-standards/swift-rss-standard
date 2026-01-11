// swift-tools-version: 6.2

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
        .library(name: .rss, targets: [.rss]),
        .library(name: .rssITunes, targets: [.rssITunes]),
        .library(name: .rssDublinCore, targets: [.rssDublinCore]),
    ],
    dependencies: [
        .package(path: "../swift-uri-standard"),
        .package(path: "../swift-rfc-5322"),
        .package(path: "../../swift-primitives/swift-standard-library-extensions")
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

extension String {
    var tests: Self { self + " Tests" }
    var foundation: Self { self + " Foundation" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility")
    ]
}
