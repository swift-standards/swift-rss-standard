import RFC_5322
import RSS_Standard
import Testing
import URI_Standard

@Suite
struct `RSS channels` {

    @Test
    func `a channel needs a title, a link and a description`() throws {
        let channel = RSS.Channel(
            title: "Test Feed",
            link: try URI("https://example.com"),
            description: "A test feed"
        )

        #expect(channel.title == "Test Feed")
        #expect(channel.link.value == "https://example.com")
        #expect(channel.description == "A test feed")
        #expect(channel.items.isEmpty)
    }

    @Test
    func `a channel records publication metadata`() throws {
        let pubDate = try RFC_5322.Date(
            year: 2025,
            month: 1,
            day: 1,
            hour: 12,
            minute: 0,
            second: 0
        )
        let channel = RSS.Channel(
            title: "Test Feed",
            link: try URI("https://example.com"),
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

    @Test
    func `a channel carries its items`() throws {
        let channel = RSS.Channel(
            title: "Test Feed",
            link: try URI("https://example.com"),
            description: "A test feed",
            items: [
                try RSS.Item(
                    title: "Test Item",
                    description: "Item description",
                    link: try URI("https://example.com/item1")
                )
            ]
        )

        #expect(channel.items.count == 1)
        #expect(channel.items[0].title == "Test Item")
        #expect(channel.items[0].description == "Item description")
    }

    @Test
    func `a channel category may name its domain`() throws {
        let channel = RSS.Channel(
            title: "Test Feed",
            link: try URI("https://example.com"),
            description: "A test feed",
            categories: [
                RSS.Category(domain: "https://example.com/categories", value: "Technology"),
                "News",
            ]
        )

        #expect(channel.categories[0].domain == "https://example.com/categories")
        #expect(channel.categories[0].value == "Technology")
        #expect(channel.categories[1].domain == nil)
        #expect(channel.categories[1].value == "News")
    }

    @Test
    func `an item needs a title or a description`() throws {
        #expect(try RSS.Item(title: "Test").description == nil)
        #expect(try RSS.Item(description: "Test description").title == nil)

        #expect(throws: RSS.Error.itemRequiresTitleOrDescription) {
            try RSS.Item()
        }
    }

    @Test
    func `an image stays within the maximum width and height`() throws {
        let image = try RSS.Image(
            url: try URI("https://example.com/logo.png"),
            title: "Logo",
            link: try URI("https://example.com"),
            width: 88,
            height: 31
        )

        #expect(image.width == 88)
        #expect(image.height == 31)

        #expect(throws: RSS.Error.imageWidthExceedsMaximum(145)) {
            try RSS.Image(
                url: try URI("https://example.com/logo.png"),
                title: "Logo",
                link: try URI("https://example.com"),
                width: 145
            )
        }

        #expect(throws: RSS.Error.imageHeightExceedsMaximum(401)) {
            try RSS.Image(
                url: try URI("https://example.com/logo.png"),
                title: "Logo",
                link: try URI("https://example.com"),
                height: 401
            )
        }
    }
}
