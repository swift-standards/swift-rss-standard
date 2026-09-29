import RFC_5322
import RSS_Standard
import Testing
import URI_Standard

@Suite
struct `README examples` {

    @Test
    func `Quick Start writes a blog feed`() throws {
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

        #expect(channel.title == "My Blog")
        #expect(channel.link.value == "https://example.com")
        #expect(channel.language == "en-US")
        #expect(channel.items.count == 1)
        #expect(channel.items[0].title == "First Post")
    }

    @Test
    func `Usage Examples writes a podcast feed with an enclosure`() throws {
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

        #expect(channel.categories.count == 1)
        #expect(channel.items[0].enclosure?.type == "audio/mpeg")
        #expect(channel.items[0].guid?.isPermaLink == false)
    }
}
