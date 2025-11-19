import Testing
@testable import RSS_Standard

@Suite("RSS Channel Tests")
struct RSSChannelTests {
    @Test("Channel creation with required fields")
    func basicChannelCreation() async throws {
        let channel = RSS.Channel(
            title: "Test Feed",
            link: URL(string: "https://example.com")!,
            description: "A test feed"
        )

        #expect(channel.title == "Test Feed")
        #expect(channel.link.absoluteString == "https://example.com")
        #expect(channel.description == "A test feed")
        #expect(channel.items.isEmpty)
    }

    @Test("Channel with optional fields")
    func channelWithOptionalFields() async throws {
        let pubDate = Date()
        let channel = RSS.Channel(
            title: "Test Feed",
            link: URL(string: "https://example.com")!,
            description: "A test feed",
            language: "en-US",
            copyright: "© 2025",
            managingEditor: "editor@example.com",
            webMaster: "webmaster@example.com",
            pubDate: pubDate,
            generator: "My Generator"
        )

        #expect(channel.language == "en-US")
        #expect(channel.copyright == "© 2025")
        #expect(channel.managingEditor == "editor@example.com")
        #expect(channel.webMaster == "webmaster@example.com")
        #expect(channel.pubDate == pubDate)
        #expect(channel.generator == "My Generator")
    }

    @Test("Channel with items")
    func channelWithItems() async throws {
        let item = try RSS.Item(
            title: "Test Item",
            description: "Item description",
            link: URL(string: "https://example.com/item1")!
        )

        let channel = RSS.Channel(
            title: "Test Feed",
            link: URL(string: "https://example.com")!,
            description: "A test feed",
            items: [item]
        )

        #expect(channel.items.count == 1)
        #expect(channel.items[0].title == "Test Item")
        #expect(channel.items[0].description == "Item description")
    }

    @Test("Channel with categories")
    func channelWithCategories() async throws {
        let channel = RSS.Channel(
            title: "Test Feed",
            link: URL(string: "https://example.com")!,
            description: "A test feed",
            categories: [
                RSS.Category(domain: "https://example.com/categories", value: "Technology"),
                RSS.Category(value: "News")
            ]
        )

        #expect(channel.categories.count == 2)
        #expect(channel.categories[0].domain == "https://example.com/categories")
        #expect(channel.categories[0].value == "Technology")
        #expect(channel.categories[1].domain == nil)
        #expect(channel.categories[1].value == "News")
    }

    @Test("Item validation - requires title or description")
    func itemValidation() async throws {
        // Should succeed with title
        let item1 = try RSS.Item(title: "Test")
        #expect(item1.title == "Test")
        #expect(item1.description == nil)

        // Should succeed with description
        let item2 = try RSS.Item(description: "Test description")
        #expect(item2.title == nil)
        #expect(item2.description == "Test description")

        // Should succeed with both
        let item3 = try RSS.Item(title: "Title", description: "Description")
        #expect(item3.title == "Title")
        #expect(item3.description == "Description")

        // Should fail with neither
        #expect(throws: RSS.ValidationError.itemRequiresTitleOrDescription) {
            try RSS.Item()
        }
    }

    @Test("Image validation - width and height limits")
    func imageValidation() async throws {
        // Valid image
        let validImage = try RSS.Image(
            url: URL(string: "https://example.com/logo.png")!,
            title: "Logo",
            link: URL(string: "https://example.com")!,
            width: 88,
            height: 31
        )
        #expect(validImage.width == 88)
        #expect(validImage.height == 31)

        // Width exceeds maximum
        #expect(throws: RSS.ValidationError.imageWidthExceedsMaximum(145)) {
            try RSS.Image(
                url: URL(string: "https://example.com/logo.png")!,
                title: "Logo",
                link: URL(string: "https://example.com")!,
                width: 145
            )
        }

        // Height exceeds maximum
        #expect(throws: RSS.ValidationError.imageHeightExceedsMaximum(401)) {
            try RSS.Image(
                url: URL(string: "https://example.com/logo.png")!,
                title: "Logo",
                link: URL(string: "https://example.com")!,
                height: 401
            )
        }
    }
}
