extension RSS {

    public struct CloudProtocol: Hashable, Sendable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension RSS.CloudProtocol {

    public static let xmlRpc = RSS.CloudProtocol(rawValue: "xml-rpc")
    public static let soap11 = RSS.CloudProtocol(rawValue: "soap 1.1")
    public static let httpPost = RSS.CloudProtocol(rawValue: "http-post")
}

extension RSS.CloudProtocol: RawRepresentable {}

extension RSS.CloudProtocol: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension RSS.CloudProtocol: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self.init(rawValue: rawValue)
    }
}

extension RSS.CloudProtocol: CustomStringConvertible {
    public var description: String { rawValue }
}
