public import URI_Standard

extension RSS {

    public struct GUID: Hashable, Sendable {
        public let value: String
        public let isPermaLink: Bool

        public init(_ value: String, isPermaLink: Bool = true) throws(Error) {

            if isPermaLink {
                let uri: URI?
                do throws(URIError) {
                    uri = try URI(value)
                } catch {
                    uri = nil
                }
                guard let uri, uri.scheme != nil else {
                    throw Error.invalidPermalink(value)
                }
            }

            self.value = value
            self.isPermaLink = isPermaLink
        }

        public init(uri: URI) {
            self.value = uri.value
            self.isPermaLink = true
        }

        private init(_ value: String, _ isPermaLink: Bool, unchecked: Void) {
            self.value = value
            self.isPermaLink = isPermaLink
        }
    }
}

extension RSS.GUID {

    static func makeUnchecked(_ value: String, isPermaLink: Bool = true) -> RSS.GUID {
        RSS.GUID(value, isPermaLink, unchecked: ())
    }
}

extension RSS.GUID: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(String.self, forKey: .value)
        let isPermaLink = try container.decodeIfPresent(Bool.self, forKey: .isPermaLink) ?? true

        self = RSS.GUID.makeUnchecked(value, isPermaLink: isPermaLink)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(isPermaLink, forKey: .isPermaLink)
    }
}

extension RSS.GUID: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self = RSS.GUID.makeUnchecked(value, isPermaLink: true)
    }
}
