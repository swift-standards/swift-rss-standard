import Testing
@testable import RSS_Standard

@Suite("GUID Validation")
struct GUIDTests {

    @Test("GUID from UUID is not a permalink")
    func guidFromUUID() {
        let uuid = UUID()
        let guid = RSS.GUID(uuid: uuid)

        #expect(guid.value == uuid.uuidString)
        #expect(guid.isPermaLink == false)
    }

    @Test("GUID from URL is a permalink")
    func guidFromURL() {
        let url = URL(string: "https://example.com/post/123")!
        let guid = RSS.GUID(url: url)

        #expect(guid.value == "https://example.com/post/123")
        #expect(guid.isPermaLink == true)
    }

    @Test("Valid permalink string succeeds")
    func validPermalinkString() throws {
        let guid = try RSS.GUID("https://example.com/post/456", isPermaLink: true)

        #expect(guid.value == "https://example.com/post/456")
        #expect(guid.isPermaLink == true)
    }

    @Test("Invalid permalink string throws")
    func invalidPermalinkString() {
        #expect(throws: RSS.ValidationError.self) {
            try RSS.GUID("not a valid url", isPermaLink: true)
        }
    }

    @Test("Non-permalink string with invalid format succeeds")
    func nonPermalinkWithInvalidURL() throws {
        // When isPermaLink is false, any string is valid
        let guid = try RSS.GUID("my-custom-id-123", isPermaLink: false)

        #expect(guid.value == "my-custom-id-123")
        #expect(guid.isPermaLink == false)
    }

    @Test("String literal creates unchecked GUID")
    func stringLiteral() {
        let guid: RSS.GUID = "tag:example.com,2025:post-123"

        #expect(guid.value == "tag:example.com,2025:post-123")
        #expect(guid.isPermaLink == true) // Default for string literals
    }

    @Test("GUID validation error message")
    func validationErrorMessage() {
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

@Suite("GUID Codable")
struct GUIDCodableTests {

    @Test("Encode GUID with permalink")
    func encodePermalink() throws {
        let guid = try RSS.GUID("https://example.com/post", isPermaLink: true)
        let encoder = JSONEncoder()
        let data = try encoder.encode(guid)
        let json = String(data: data, encoding: .utf8)!

        // JSON may escape forward slashes as \/ which is valid
        #expect(json.contains("example.com"))
        #expect(json.contains("\"isPermaLink\":true"))
    }

    @Test("Decode GUID uses unchecked initializer")
    func decodeInvalidPermalink() throws {
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
