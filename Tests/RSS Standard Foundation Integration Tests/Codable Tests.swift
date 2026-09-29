import Foundation
import RFC_5322
import RSS_Standard
import RSS_Standard_Dublin_Core
import RSS_Standard_Foundation_Integration
import RSS_Standard_iTunes
import Testing
import URI_Standard

@Suite
struct `RSS through Foundation Codable` {

    @Test
    func `a channel survives a JSON round trip`() throws {
        let channel = RSS.Channel(
            title: "My Blog",
            link: try URI("https://example.com"),
            description: "A blog about Swift development",
            language: "en-US",
            categories: ["Technology"],
            skipHours: [12],
            skipDays: [.monday],
            items: [
                try RSS.Item(
                    title: "First Post",
                    description: "Hello, world!",
                    link: try URI("https://example.com/post1"),
                    guid: try RSS.GUID("https://example.com/post1"),
                    pubDate: try RFC_5322.Date(year: 2025, month: 1, day: 1)
                )
            ]
        )

        let decoded = try JSONDecoder().decode(
            RSS.Channel.self,
            from: try JSONEncoder().encode(channel)
        )

        #expect(decoded == channel)
    }

    @Test
    func `a cloud registration survives a JSON round trip`() throws {
        let cloud = RSS.Cloud(
            domain: "rpc.example.com",
            port: 80,
            path: "/RPC2",
            registerProcedure: "pingMe",
            protocol: .xmlRpc
        )

        let decoded = try JSONDecoder().decode(
            RSS.Cloud.self,
            from: try JSONEncoder().encode(cloud)
        )

        #expect(decoded == cloud)
    }

    @Test
    func `a podcast channel survives a JSON round trip`() throws {
        let channel = iTunes.Channel(
            author: "John Doe",
            owner: iTunes.Owner(
                name: "Jane Smith",
                email: try RFC_5322.Mailbox("jane@example.com")
            ),
            image: try URI("https://example.com/art.jpg"),
            categories: [iTunes.Category(text: "Technology", subcategory: "Podcasting")],
            type: .episodic
        )

        let decoded = try JSONDecoder().decode(
            iTunes.Channel.self,
            from: try JSONEncoder().encode(channel)
        )

        #expect(decoded == channel)
    }

    @Test
    func `a podcast episode survives a JSON round trip`() throws {
        let episode = iTunes.Item(
            duration: iTunes.Duration(hours: 1, minutes: 30, seconds: 45),
            episodeType: .full,
            season: 1,
            episode: 5
        )

        let decoded = try JSONDecoder().decode(
            iTunes.Item.self,
            from: try JSONEncoder().encode(episode)
        )

        #expect(decoded == episode)
    }

    @Test
    func `Dublin Core metadata survives a JSON round trip`() throws {
        let metadata = DublinCore.Metadata(
            creator: ["Alice", "Bob"],
            subject: ["Swift"],
            publisher: "Example Press",
            date: try RFC_5322.Date(year: 2025, month: 1, day: 1),
            rights: "© 2025"
        )

        let decoded = try JSONDecoder().decode(
            DublinCore.Metadata.self,
            from: try JSONEncoder().encode(metadata)
        )

        #expect(decoded == metadata)
    }

    @Test
    func `decoding a permalink GUID that is not a URI fails`() throws {
        let json = Data(#"{"value":"not a url","isPermaLink":true}"#.utf8)

        #expect(throws: RSS.Error.invalidPermalink("not a url")) {
            try JSONDecoder().decode(RSS.GUID.self, from: json)
        }
    }

    @Test
    func `decoding an hour outside the day fails`() throws {
        #expect(throws: (any Swift.Error).self) {
            try JSONDecoder().decode(RSS.Hour.self, from: Data("24".utf8))
        }
    }
}
