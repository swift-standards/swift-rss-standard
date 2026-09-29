# swift-rss-standard

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-standards/swift-rss-standard/workflows/CI/badge.svg)](https://github.com/swift-standards/swift-rss-standard/actions/workflows/ci.yml)

Type-safe RSS 2.0 feed type definitions for Swift with support for iTunes podcast extensions and Dublin Core metadata.

## Overview

swift-rss-standard provides complete RSS 2.0 specification support with type-safe Swift types for representing RSS feed data structures. Includes dedicated support for podcast feeds via iTunes extensions and metadata enrichment through Dublin Core.

## Features

- **Complete RSS 2.0 Support**: All required and optional channel and item elements per RSS 2.0 specification
- **iTunes Podcast Extensions**: Full support for podcast-specific metadata (duration, episode type, season/episode numbers)
- **Dublin Core Metadata**: Rich metadata support for creators, subjects, publishers
- **Type Safety**: Compile-time validation with Hashable and Sendable conformance
- **Foundation Bridging**: Optional `RSS Standard Foundation Integration` product adds Codable
- **Validation**: Failable initializers enforce RSS requirements (items require title OR description)
- **Swift 6.0 Concurrency**: Strict concurrency mode with complete Sendable conformance

## Installation

Add swift-rss-standard to your Package.swift dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-rss-standard", from: "0.0.4")
]
```

Then add the products you need to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "RSS Standard", package: "swift-rss-standard"),
        .product(name: "RSS Standard iTunes", package: "swift-rss-standard"),
        .product(name: "RSS Standard Dublin Core", package: "swift-rss-standard"),
        .product(name: "RSS Standard Foundation Integration", package: "swift-rss-standard")
    ]
)
```

## Quick Start

```swift
import RFC_5322
import RSS_Standard
import URI_Standard

let channel = RSS.Channel(
    title: "My Blog",
    link: try URI("https://example.com"),
    description: "A blog about Swift development",
    language: "en-US",
    items: [
        try RSS.Item(
            title: "First Post",
            description: "Hello, world!",
            link: try URI("https://example.com/post1"),
            pubDate: try RFC_5322.Date(year: 2025, month: 1, day: 1)
        )
    ]
)
```

## Usage Examples

### Podcast Feed with iTunes Extensions

```swift
import RFC_5322
import RSS_Standard
import RSS_Standard_iTunes
import URI_Standard

let channel = RSS.Channel(
    title: "Tech Podcast",
    link: try URI("https://example.com/podcast"),
    description: "A podcast about technology",
    categories: [
        RSS.Category(domain: "https://example.com/cats", value: "Tech")
    ],
    items: [
        try RSS.Item(
            title: "Episode 1: Getting Started",
            description: "In this episode we discuss...",
            link: try URI("https://example.com/episode1"),
            categories: ["Technology", "Programming"],
            enclosure: RSS.Enclosure(
                url: try URI("https://example.com/audio.mp3"),
                length: 123456,
                type: "audio/mpeg"
            ),
            guid: try RSS.GUID("unique-id-123", isPermaLink: false),
            pubDate: try RFC_5322.Date(year: 2025, month: 1, day: 1)
        )
    ]
)
```

Wire syntax lives in the coder sibling; this package is the RSS domain model.

## Related Packages

- [swift-rfc-4287](https://github.com/swift-ietf/swift-rfc-4287): Type-safe Atom feed generation and parsing for Swift (RFC 4287 implementation)
- [swift-syndication](https://github.com/coenttb/swift-syndication): Unified syndication API supporting RSS, Atom, and JSON Feed with format conversion
- [swift-rfc-2822](https://github.com/swift-ietf/swift-rfc-2822): RFC 2822 date formatting for email and RSS dates

## License

This project is licensed under the Apache License 2.0. See LICENSE for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
