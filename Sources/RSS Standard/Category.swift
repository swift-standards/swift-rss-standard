extension RSS {

    public struct Category: Hashable, Sendable {
        public let domain: Taxonomy?
        public let value: String

        @_disfavoredOverload
        public init(domain: Taxonomy? = nil, value: String) {
            self.domain = domain
            self.value = value
        }
    }
}

extension RSS.Category: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self.init(domain: nil, value: value)
    }
}
