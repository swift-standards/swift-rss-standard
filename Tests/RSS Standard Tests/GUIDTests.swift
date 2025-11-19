import Testing
@testable import RSS_Standard
import RFC_3986

@Suite
struct `GUID Validation` {

    @Test
    func `GUID from URI is a permalink`() throws {
        let uri = try RFC_3986.URI("https://example.com/post/123")
        let guid = RSS.GUID(uri: uri)

        #expect(guid.value == "https://example.com/post/123")
        #expect(guid.isPermaLink == true)
    }

    @Test
    func `Valid permalink string succeeds`() throws {
        let guid = try RSS.GUID("https://example.com/post/456", isPermaLink: true)

        #expect(guid.value == "https://example.com/post/456")
        #expect(guid.isPermaLink == true)
    }

    @Test
    func `Invalid permalink string throws`() {
        #expect(throws: RSS.ValidationError.self) {
            try RSS.GUID("not a valid url", isPermaLink: true)
        }
    }

    @Test
    func `Non-permalink string with invalid format succeeds`() throws {
        // When isPermaLink is false, any string is valid
        let guid = try RSS.GUID("my-custom-id-123", isPermaLink: false)

        #expect(guid.value == "my-custom-id-123")
        #expect(guid.isPermaLink == false)
    }

    @Test
    func `String literal creates unchecked GUID`() {
        let guid: RSS.GUID = "tag:example.com,2025:post-123"

        #expect(guid.value == "tag:example.com,2025:post-123")
        #expect(guid.isPermaLink == true) // Default for string literals
    }

    @Test
    func `GUID validation error message`() {
        do {
            _ = try RSS.GUID("invalid url!", isPermaLink: true)
            Issue.record("Expected ValidationError to be thrown")
        } catch let error as RSS.ValidationError {
            switch error {
            case .invalidPermalink(let value):
                #expect(value == "invalid url!")
            default:
                Issue.record("Expected invalidPermalink error")
            }
        } catch {
            Issue.record("Expected RSS.ValidationError, got \(type(of: error))")
        }
    }
}

@Suite
struct `GUID Codable` {

    @Test
    func `Encode GUID with permalink`() throws {
        let guid = try RSS.GUID("https://example.com/post", isPermaLink: true)
        let encoder = JSONEncoder()
        let data = try encoder.encode(guid)
        let json = String(data: data, encoding: .utf8)!

        // JSON may escape forward slashes as \/ which is valid
        #expect(json.contains("example.com"))
        #expect(json.contains("\"isPermaLink\":true"))
    }

    @Test
    func `Decode GUID uses unchecked initializer`() throws {
        // Decoding should succeed even with invalid permalink
        // (for compatibility with existing data)
        let json = """
        {"value":"not a url","isPermaLink":true}
        """
        let decoder = JSONDecoder()
        let guid = try decoder.decode(RSS.GUID.self, from: json.data(using: .utf8)!)

        #expect(guid.value == "not a url")
        #expect(guid.isPermaLink == true)
    }
}
