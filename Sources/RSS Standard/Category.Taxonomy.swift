extension RSS.Category {

    /// The system a category belongs to, RSS 2.0's `domain` attribute: not a DNS name and not necessarily a URI, as the specification's own `Syndic8` shows.
    public struct Taxonomy: Hashable, Sendable {

        public let value: String

        public init(_ value: String) {
            self.value = value
        }
    }
}

extension RSS.Category.Taxonomy: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension RSS.Category.Taxonomy: CustomStringConvertible {

    public var description: String {
        value
    }
}
