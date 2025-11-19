
extension RSS {
    /// Represents a cloud protocol for RSS publish-subscribe
    public struct CloudProtocol: Hashable, Sendable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        // Standard protocols from RSS 2.0 specification
        public static let xmlRpc = CloudProtocol(rawValue: "xml-rpc")
        public static let soap11 = CloudProtocol(rawValue: "soap 1.1")
        public static let httpPost = CloudProtocol(rawValue: "http-post")
    }
}

// MARK: - RawRepresentable
extension RSS.CloudProtocol: RawRepresentable {}

// MARK: - ExpressibleByStringLiteral
extension RSS.CloudProtocol: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

// MARK: - Codable
extension RSS.CloudProtocol: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
}

// MARK: - CustomStringConvertible
extension RSS.CloudProtocol: CustomStringConvertible {
    public var description: String { rawValue }
}
