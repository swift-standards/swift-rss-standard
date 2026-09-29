import RSS_Standard
import Testing
import URI_Standard

@Suite
struct `GUID validation` {

    @Test
    func `a GUID built from a URI is a permalink`() throws {
        let guid = RSS.GUID(uri: try URI("https://example.com/post/123"))

        #expect(guid.value == "https://example.com/post/123")
        #expect(guid.isPermaLink == true)
    }

    @Test
    func `a permalink GUID accepts an absolute URI`() throws {
        let guid = try RSS.GUID("https://example.com/post/456", isPermaLink: true)

        #expect(guid.value == "https://example.com/post/456")
        #expect(guid.isPermaLink == true)
    }

    @Test
    func `a permalink GUID refuses a value that is not a URI`() {
        #expect(throws: RSS.Error.invalidPermalink("invalid url!")) {
            try RSS.GUID("invalid url!", isPermaLink: true)
        }
    }

    @Test
    func `a GUID that is not a permalink accepts any value`() throws {
        let guid = try RSS.GUID("my-custom-id-123", isPermaLink: false)

        #expect(guid.value == "my-custom-id-123")
        #expect(guid.isPermaLink == false)
    }

    @Test
    func `a string literal writes a GUID`() {
        let guid: RSS.GUID = "tag:example.com,2025:post-123"

        #expect(guid.value == "tag:example.com,2025:post-123")
        #expect(guid.isPermaLink == true)
    }
}
