
extension RSS {
    /// RSS 2.0 Category
    public struct Category: Hashable, Sendable, Codable {
        public let domain: String? // optional URI
        public let value: String

        @_disfavoredOverload
        public init(domain: String? = nil, value: String) {
            self.domain = domain
            self.value = value
        }
    }
}

// MARK: - ExpressibleByStringLiteral
extension RSS.Category: ExpressibleByStringLiteral {
    /// Creates a category from a string literal (without domain)
    ///
    /// Example:
    /// ```swift
    /// let category: RSS.Category = "Technology"
    /// // Equivalent to: RSS.Category(value: "Technology")
    /// ```
    public init(stringLiteral value: String) {
        self.init(domain: nil, value: value)
    }
}
