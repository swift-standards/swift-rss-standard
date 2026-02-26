import RFC_5322
import Testing
import URI_Standard

@testable import RSS_Standard
@testable import RSS_Standard_Dublin_Core
@testable import RSS_Standard_iTunes

@Suite
struct `Extension Tests` {
    @Test func iTunesDurationParsing() async throws {
        // Test HH:MM:SS format
        let duration1 = iTunes.Duration(string: "1:30:45")
        #expect(duration1?.hours == 1)
        #expect(duration1?.minutes == 30)
        #expect(duration1?.seconds == 45)
        #expect(duration1?.totalSeconds == 5445)

        // Test MM:SS format
        let duration2 = iTunes.Duration(string: "45:30")
        #expect(duration2?.hours == nil)
        #expect(duration2?.minutes == 45)
        #expect(duration2?.seconds == 30)
        #expect(duration2?.totalSeconds == 2730)

        // Test SS format
        let duration3 = iTunes.Duration(string: "90")
        #expect(duration3?.totalSeconds == 90)
    }

    @Test func iTunesDurationFormatting() async throws {
        let duration1 = iTunes.Duration(hours: 1, minutes: 30, seconds: 45)
        #expect(duration1.formatted == "1:30:45")

        let duration2 = iTunes.Duration(hours: nil, minutes: 5, seconds: 30)
        #expect(duration2.formatted == "5:30")

        let duration3 = iTunes.Duration(totalSeconds: 3665)
        #expect(duration3.formatted == "1:01:05")
    }

    @Test func iTunesChannelExtension() async throws {
        let ext = iTunes.ChannelExtension(
            author: "John Doe",
            owner: iTunes.Owner(name: "Jane Smith", email: "jane@example.com"),
            image: try URI("https://example.com/art.jpg"),
            categories: [
                iTunes.Category(text: "Technology", subcategory: "Podcasting")
            ],
            explicit: false,
            type: .episodic
        )

        #expect(ext.author == "John Doe")
        #expect(ext.owner?.name == "Jane Smith")
        #expect(ext.categories.count == 1)
        #expect(ext.type == .episodic)
    }

    @Test func iTunesItemExtension() async throws {
        let duration = iTunes.Duration(hours: 0, minutes: 45, seconds: 30)
        let ext = iTunes.ItemExtension(
            duration: duration,
            episodeType: .full,
            season: 1,
            episode: 5
        )

        #expect(ext.duration?.totalSeconds == 2730)
        #expect(ext.episodeType == .full)
        #expect(ext.season == 1)
        #expect(ext.episode == 5)
    }

    @Test func dublinCoreMetadata() async throws {
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

    @Test func durationExpressibleByIntegerLiteral() async throws {
        let duration: iTunes.Duration = 3665
        #expect(duration.hours == 1)
        #expect(duration.minutes == 1)
        #expect(duration.seconds == 5)
        #expect(duration.totalSeconds == 3665)
        #expect(duration.formatted == "1:01:05")
    }

    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    @Test func durationSwiftDurationConversion() async throws {
        // Test creating iTunes.Duration from Swift.Duration
        let swiftDuration: Swift.Duration = .seconds(3665)
        let itunesDuration = iTunes.Duration(swiftDuration)
        #expect(itunesDuration.hours == 1)
        #expect(itunesDuration.minutes == 1)
        #expect(itunesDuration.seconds == 5)
        #expect(itunesDuration.totalSeconds == 3665)

        // Test converting iTunes.Duration to Swift.Duration
        let duration = iTunes.Duration(hours: 1, minutes: 30, seconds: 45)
        let converted = duration.swiftDuration
        #expect(converted == .seconds(5445))
    }

    @Test func durationCustomStringConvertible() async throws {
        let duration1 = iTunes.Duration(hours: 1, minutes: 30, seconds: 45)
        #expect(String(describing: duration1) == "1:30:45")

        let duration2 = iTunes.Duration(hours: nil, minutes: 5, seconds: 30)
        #expect(String(describing: duration2) == "5:30")
    }

    @Test func categoryExpressibleByStringLiteral() async throws {
        let category: RSS.Category = "Technology"
        #expect(category.value == "Technology")
        #expect(category.domain == nil)

        // Test in array context
        let categories: [RSS.Category] = ["News", "Sports", "Politics"]
        #expect(categories.count == 3)
        #expect(categories[0].value == "News")
        #expect(categories[1].value == "Sports")
    }

    @Test func guidExpressibleByStringLiteral() async throws {
        let guid: RSS.GUID = "https://example.com/post/123"
        #expect(guid.value == "https://example.com/post/123")
        #expect(guid.isPermaLink == true)

        // Test in array context
        let guids: [RSS.GUID] = ["https://example.com/1", "https://example.com/2"]
        #expect(guids.count == 2)
        #expect(guids[0].isPermaLink == true)
    }
}
