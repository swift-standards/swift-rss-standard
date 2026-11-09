import RFC_5322
import RSS_Standard
import RSS_Standard_XML
import Testing
import URI_Standard
import W3C_XML

@Suite struct `An RSS channel written as XML` {
    func channel() throws -> RSS.Channel {
        RSS.Channel(
            title: "Wetten & regels",
            link: try URI("https://feed.rule.law/nl"),
            description: "What changes in Dutch law",
            categories: [RSS.Category(domain: "https://rule.law/series", value: "stb")],
            skipHours: [3, 1],
            items: [
                try RSS.Item(
                    title: "Staatsblad 2026, 368",
                    link: try URI("https://zoek.officielebekendmakingen.nl/stb-2026-368"),
                    enclosure: RSS.Enclosure(url: try URI("https://example.org/stb-2026-368.pdf"), length: 1024, type: "application/pdf"),
                    guid: try RSS.GUID("stb-2026-368", isPermaLink: false),
                    pubDate: try RFC_5322.Date(year: 2026, month: 11, day: 5)
                ),
            ]
        )
    }

    func parsed() throws -> W3C_XML.Element {
        try W3C_XML.parse(W3C_XML.Document(try channel()).encode()).root
    }

    @Test func `the document is an rss element of version 2.0 holding one channel`() throws {
        let root = try parsed()
        #expect(root.name.local == "rss")
        #expect(root.attributes.first { $0.name.local == "version" }?.value == "2.0")
        #expect(root.children.map(\.name.local) == ["channel"])
    }

    @Test func `the channel's required elements come first and text survives escaping`() throws {
        let channel = try #require(try parsed().children.first)
        #expect(channel.children.prefix(3).map(\.name.local) == ["title", "link", "description"])
        #expect(channel.children.first?.textContent == "Wetten & regels")
        #expect(channel.children.first { $0.name.local == "category" }?.attributes.first?.value == "https://rule.law/series")
    }

    @Test func `skipped hours are written in order`() throws {
        let channel = try #require(try parsed().children.first)
        let hours = channel.children.first { $0.name.local == "skipHours" }?.children.map(\.textContent)
        #expect(hours == ["1", "3"])
    }

    @Test func `an item carries its guid's permalink flag, its enclosure and an RFC 5322 date`() throws {
        let item = try #require(try parsed().children.first?.children.first { $0.name.local == "item" })
        let guid = try #require(item.children.first { $0.name.local == "guid" })
        #expect(guid.textContent == "stb-2026-368")
        #expect(guid.attributes.first { $0.name.local == "isPermaLink" }?.value == "false")
        #expect(item.children.first { $0.name.local == "enclosure" }?.attributes.map(\.value) == ["https://example.org/stb-2026-368.pdf", "1024", "application/pdf"])
        #expect(item.children.first { $0.name.local == "pubDate" }?.textContent == (try RFC_5322.Date(year: 2026, month: 11, day: 5)).description)
    }
}
