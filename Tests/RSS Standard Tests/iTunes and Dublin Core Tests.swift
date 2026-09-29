import RFC_5322
import RSS_Standard
import RSS_Standard_Dublin_Core
import RSS_Standard_iTunes
import Testing
import URI_Standard

@Suite
struct `iTunes and Dublin Core extensions` {

    @Test
    func `a podcast channel carries an owner, artwork and categories`() throws {
        let channel = iTunes.Channel(
            author: "John Doe",
            owner: iTunes.Owner(
                name: "Jane Smith",
                email: try RFC_5322.Mailbox("jane@example.com")
            ),
            image: try URI("https://example.com/art.jpg"),
            categories: [
                iTunes.Category(text: "Technology", subcategory: "Podcasting")
            ],
            explicit: false,
            type: .episodic
        )

        #expect(channel.author == "John Doe")
        #expect(channel.owner?.name == "Jane Smith")
        #expect(channel.categories.count == 1)
        #expect(channel.type == .episodic)
    }

    @Test
    func `a podcast episode carries a duration, season and episode number`() throws {
        let episode = iTunes.Item(
            duration: iTunes.Duration(hours: 0, minutes: 45, seconds: 30),
            episodeType: .full,
            season: 1,
            episode: 5
        )

        #expect(episode.duration?.totalSeconds == 2730)
        #expect(episode.episodeType == .full)
        #expect(episode.season == 1)
        #expect(episode.episode == 5)
    }

    @Test
    func `a duration is written as a total number of seconds`() {
        let duration: iTunes.Duration = 3665

        #expect(duration.hours == 1)
        #expect(duration.minutes == 1)
        #expect(duration.seconds == 5)
        #expect(duration.totalSeconds == 3665)
    }

    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    @Test
    func `a duration converts to and from a Swift duration`() {
        let duration = iTunes.Duration(Swift.Duration.seconds(3665))

        #expect(duration.hours == 1)
        #expect(duration.minutes == 1)
        #expect(duration.seconds == 5)
        #expect(iTunes.Duration(hours: 1, minutes: 30, seconds: 45).swiftDuration == .seconds(5445))
    }

    @Test
    func `Dublin Core metadata records creators, subjects and a publisher`() throws {
        let metadata = DublinCore.Metadata(
            creator: ["Alice", "Bob"],
            subject: ["Swift", "Programming"],
            publisher: "Example Press",
            date: try RFC_5322.Date(year: 2025, month: 1, day: 1),
            rights: "© 2025"
        )

        #expect(metadata.creator.count == 2)
        #expect(metadata.subject.contains("Swift"))
        #expect(metadata.publisher == "Example Press")
    }
}
