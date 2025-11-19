import Testing
@testable import RSS_Standard
import RFC_3986

@Suite("URI.Representable Integration Tests")
struct URIRepresentableTests {

    @Test("Channel with RFC_3986.URI works")
    func channelWithURI() throws {
        let uri: RFC_3986.URI = "https://example.com"
        let channel = RSS.Channel(
            title: "Test",
            link: uri,
            description: "Test channel"
        )

        #expect(channel.link.absoluteString == "https://example.com")
    }

    @Test("Item with RFC_3986.URI works")
    func itemWithURI() throws {
        let uri: RFC_3986.URI = "https://example.com/item"
        let item = try RSS.Item(
            title: "Test Item",
            link: uri
        )

        #expect(item.link?.absoluteString == "https://example.com/item")
    }

    @Test("Enclosure with RFC_3986.URI works")
    func enclosureWithURI() {
        let uri: RFC_3986.URI = "https://example.com/media.mp3"
        let enclosure = RSS.Enclosure(
            url: uri,
            length: 1024,
            type: "audio/mpeg"
        )

        #expect(enclosure.url.absoluteString == "https://example.com/media.mp3")
    }
}
