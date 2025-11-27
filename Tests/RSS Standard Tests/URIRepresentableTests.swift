import Testing
@testable import RSS_Standard
import URI_Standard

@Suite
struct `URI.Representable Integration Tests` {

    @Test
    func `Channel with URI works`() throws {
        let uri: URI = try .init("https://example.com")
        let channel = RSS.Channel(
            title: "Test",
            link: uri,
            description: "Test channel"
        )

        #expect(channel.link.value == "https://example.com")
    }

    @Test
    func `Item with URI works`() throws {
        let uri: URI = try .init("https://example.com/item")
        let item = try RSS.Item(
            title: "Test Item",
            link: uri
        )

        #expect(item.link?.value == "https://example.com/item")
    }

    @Test
    func `Enclosure with URI works`() throws {
        let uri: URI = try .init("https://example.com/media.mp3")
        let enclosure = RSS.Enclosure(
            url: uri,
            length: 1024,
            type: "audio/mpeg"
        )

        #expect(enclosure.url.value == "https://example.com/media.mp3")
    }
}
