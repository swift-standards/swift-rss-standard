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
- **Type Safety**: Compile-time validation with Hashable, Sendable, Codable conformance
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
        .product(name: "RSS", package: "swift-rss-standard"),
        .product(name: "RSS iTunes", package: "swift-rss-standard"),  // Optional: for podcast feeds
        .product(name: "RSS Dublin Core", package: "swift-rss-standard")  // Optional: for metadata
    ]
)
```

## Quick Start

```swift
import RSS_Standard

// Create a basic RSS feed model
let channel = RSS.Channel(
    title: "My Blog",
    link: URL(string: "https://example.com")!,
    description: "A blog about Swift development",
    language: "en-US",
    items: [
        try! RSS.Item(
            title: "First Post",
            description: "Hello, world!",
            link: URL(string: "https://example.com/post1")!,
            pubDate: Date()
        )
    ]
)

```

## Usage Examples

### Podcast Feed with iTunes Extensions

```swift
import RSS_Standard
import RSS_Standard_iTunes

let channel = RSS.Channel(
    title: "My Podcast",
    link: URL(string: "https://example.com/podcast")!,
    description: "A podcast about technology",
    items: [
        try! RSS.Item(
            title: "Episode 1: Getting Started",
            description: "In this episode we discuss...",
            link: URL(string: "https://example.com/episode1")!,
            pubDate: Date()
        )
    ]
)

```

## Related Packages

- [swift-rfc-4287](https://github.com/swift-ietf/swift-rfc-4287): Type-safe Atom feed generation and parsing for Swift (RFC 4287 implementation)
- [swift-syndication](https://github.com/coenttb/swift-syndication): Unified syndication API supporting RSS, Atom, and JSON Feed with format conversion
- [swift-rfc-2822](https://github.com/swift-ietf/swift-rfc-2822): RFC 2822 date formatting for email and RSS dates

## License

This project is licensed under the Apache License 2.0. See LICENSE for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
