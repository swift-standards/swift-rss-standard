extension RSS.Cloud {

    public struct `Protocol`: Hashable, Sendable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension RSS.Cloud.`Protocol` {

    public static let xmlRpc = Self(rawValue: "xml-rpc")
    public static let soap11 = Self(rawValue: "soap 1.1")
    public static let httpPost = Self(rawValue: "http-post")
}

extension RSS.Cloud.`Protocol`: RawRepresentable {}

extension RSS.Cloud.`Protocol`: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension RSS.Cloud.`Protocol`: CustomStringConvertible {
    public var description: String { rawValue }
}
