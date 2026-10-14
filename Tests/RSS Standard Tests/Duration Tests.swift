import RSS_Standard_iTunes
import Testing

@Suite
struct `ITunes duration parsing` {

    @Test
    func `hours, minutes and seconds parse into their components`() throws {
        let duration = try ITunes.Duration("1:30:45")

        #expect(duration.hours == 1)
        #expect(duration.minutes == 30)
        #expect(duration.seconds == 45)
        #expect(duration.totalSeconds == 5445)
    }

    @Test
    func `minutes and seconds parse without hours`() throws {
        let duration = try ITunes.Duration("45:30")

        #expect(duration.hours == nil)
        #expect(duration.minutes == 45)
        #expect(duration.seconds == 30)
        #expect(duration.totalSeconds == 2730)
    }

    @Test
    func `plain seconds parse as a total number of seconds`() throws {
        #expect(try ITunes.Duration("90").totalSeconds == 90)
        #expect(try ITunes.Duration("3665") == ITunes.Duration(hours: 1, minutes: 1, seconds: 5))
    }

    @Test
    func `more than three components are refused`() {
        #expect(throws: ITunes.Duration.Error.tooManyComponents(4)) {
            try ITunes.Duration("1:2:3:4")
        }
    }

    @Test
    func `an empty value is refused`() {
        #expect(throws: ITunes.Duration.Error.invalidComponent("")) {
            try ITunes.Duration("")
        }
    }

    @Test
    func `an empty component is refused`() {
        #expect(throws: ITunes.Duration.Error.invalidComponent("")) {
            try ITunes.Duration("1::30")
        }
    }

    @Test
    func `a non-digit component is refused`() {
        #expect(throws: ITunes.Duration.Error.invalidComponent("3a")) {
            try ITunes.Duration("1:3a")
        }
        #expect(throws: ITunes.Duration.Error.invalidComponent("-5")) {
            try ITunes.Duration("-5")
        }
    }
}
