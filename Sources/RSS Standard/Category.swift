extension RSS {

    public struct Category: Hashable, Sendable {
        // swift-linter:disable:next raw concept
        // REASON: RSS 2.0's category domain names a taxonomy, not a DNS name, and needn't be a URI (the spec's own example is Syndic8), so neither Domain nor URI holds it
        public let domain: String?
        public let value: String

        @_disfavoredOverload
        // swift-linter:disable:next raw concept
        // REASON: RSS 2.0's category domain names a taxonomy, not a DNS name, and needn't be a URI (the spec's own example is Syndic8), so neither Domain nor URI holds it
        public init(domain: String? = nil, value: String) {
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
