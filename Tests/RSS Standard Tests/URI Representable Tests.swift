import RSS_Standard
import Testing
import URI_Standard

@Suite
struct `URI representable links` {

    @Test
    func `a channel link takes a URI`() throws {
        let channel = RSS.Channel(
            title: "Test",
            link: try URI("https://example.com"),
            description: "Test channel"
        )

        #expect(channel.link.value == "https://example.com")
    }

    @Test
    func `an item link takes a URI`() throws {
        let item = try RSS.Item(
            title: "Test Item",
            link: try URI("https://example.com/item")
        )

        #expect(item.link?.value == "https://example.com/item")
    }

    @Test
    func `an enclosure url takes a URI`() throws {
        let enclosure = RSS.Enclosure(
            url: try URI("https://example.com/media.mp3"),
            length: 1024,
            type: "audio/mpeg"
        )

        #expect(enclosure.url.value == "https://example.com/media.mp3")
    }
}
