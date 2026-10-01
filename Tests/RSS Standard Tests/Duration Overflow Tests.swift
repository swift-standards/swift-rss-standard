import Testing

@testable import RSS_Standard_iTunes

@Suite
struct `Duration overflow` {
    @Test(arguments: ["99999999999999999999", "1:99999999999999999999", "3000000000000000:0:0"])
    func `a duration too large for Int seconds is refused`(_ text: String) {
        #expect(throws: iTunes.Duration.Error.self) {
            try iTunes.Duration(text)
        }
    }

    @Test
    func `the largest representable duration still parses`() throws {
        let duration = try iTunes.Duration(String(Int.max))
        #expect(duration.totalSeconds == Int.max)
    }
}
