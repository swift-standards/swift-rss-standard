import Testing
@testable import RSS_Standard
@testable import RSS_Standard_iTunes
import URI_Standard
import RFC_5322

@Suite
struct `README Verification` {
    @Test
    func `Quick Start - Basic RSS feed model creation`() throws {
        // Create a basic RSS feed
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

        // Verify the model
        #expect(channel.title == "My Blog")
        #expect(channel.link.value == "https://example.com")
        #expect(channel.language == "en-US")
        #expect(channel.items.count == 1)
        #expect(channel.items[0].title == "First Post")
    }

    @Test
    func `Podcast Feed Example - model with multiple items`() throws {
        let channel = RSS.Channel(
            title: "My Podcast",
            link: try URI("https://example.com/podcast"),
            description: "A podcast about technology",
            items: [
                try RSS.Item(
                    title: "Episode 1: Getting Started",
                    description: "In this episode we discuss...",
                    link: try URI("https://example.com/episode1"),
                    pubDate: try RFC_5322.Date(year: 2025, month: 1, day: 1)
                ),
                try RSS.Item(
                    title: "Episode 2: Advanced Topics",
                    description: "Building on the basics...",
                    link: try URI("https://example.com/episode2"),
                    pubDate: try RFC_5322.Date(year: 2025, month: 1, day: 1)
                )
            ]
        )

        #expect(channel.title == "My Podcast")
        #expect(channel.items.count == 2)
        #expect(channel.items[0].title == "Episode 1: Getting Started")
        #expect(channel.items[1].title == "Episode 2: Advanced Topics")
    }

    @Test
    func `Complex feed with categories and enclosures`() throws {
        let enclosure = RSS.Enclosure(
            url: try URI("https://example.com/audio.mp3"),
            length: 123456,
            type: "audio/mpeg"
        )

        let item = try RSS.Item(
            title: "Podcast Episode",
            description: "Episode description",
            link: try URI("https://example.com/episode"),
            categories: ["Technology", "Programming"],
            enclosure: enclosure,
            guid: try RSS.GUID("unique-id-123", isPermaLink: false)
        )

        let channel = RSS.Channel(
            title: "Tech Podcast",
            link: try URI("https://example.com"),
            description: "A technology podcast",
            categories: [
                RSS.Category(domain: "https://example.com/cats", value: "Tech")
            ],
            items: [item]
        )

        #expect(channel.categories.count == 1)
        #expect(channel.items[0].enclosure?.type == "audio/mpeg")
        #expect(channel.items[0].guid?.isPermaLink == false)
    }
}
