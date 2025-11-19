
extension RSS {
    /// RSS 2.0 GUID (globally unique identifier)
    public struct GUID: Hashable, Sendable {
        public let value: String
        public let isPermaLink: Bool // default true

        /// Creates a GUID with string value and validation
        ///
        /// - Parameters:
        ///   - value: The GUID value
        ///   - isPermaLink: Whether this GUID is a permalink (default: true per RSS spec)
        /// - Throws: ValidationError.invalidPermalink if isPermaLink is true but value is not a valid URL with scheme
        public init(_ value: String, isPermaLink: Bool = true) throws {
            // Validate that permalinks are valid URLs with a scheme
            if isPermaLink {
                guard let url = URL(string: value), url.scheme != nil else {
                    throw ValidationError.invalidPermalink(value)
                }
            }

            self.value = value
            self.isPermaLink = isPermaLink
        }

        /// Creates a GUID from a UUID (isPermaLink will be false)
        ///
        /// - Parameter uuid: The UUID to use as the GUID value
        public init(uuid: UUID) {
            self.value = uuid.uuidString
            self.isPermaLink = false
        }

        /// Creates a GUID from a URL (isPermaLink will be true)
        ///
        /// URLs are always valid permalinks, so this initializer doesn't throw.
        ///
        /// - Parameter url: The URL to use as the GUID value
        public init(url: URL) {
            self.value = url.absoluteString
            self.isPermaLink = true
        }

        /// Creates a GUID without validation (for internal use, e.g., decoding)
        static func makeUnchecked(_ value: String, isPermaLink: Bool = true) -> GUID {
            GUID(value, isPermaLink, unchecked: ())
        }

        private init(_ value: String, _ isPermaLink: Bool, unchecked: Void) {
            self.value = value
            self.isPermaLink = isPermaLink
        }
    }
}

// MARK: - Codable
extension RSS.GUID: Codable {
    enum CodingKeys: String, CodingKey {
        case value
        case isPermaLink
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decode(String.self, forKey: .value)
        let isPermaLink = try container.decodeIfPresent(Bool.self, forKey: .isPermaLink) ?? true

        // Use unchecked initializer for decoding to avoid validation errors on existing data
        self = RSS.GUID.makeUnchecked(value, isPermaLink: isPermaLink)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(isPermaLink, forKey: .isPermaLink)
    }
}

// MARK: - ExpressibleByStringLiteral
extension RSS.GUID: ExpressibleByStringLiteral {
    /// Creates a GUID from a string literal (isPermaLink defaults to true)
    ///
    /// Note: This initializer uses unchecked validation. For validated initialization,
    /// use the throwing initializer `init(_:isPermaLink:)`.
    ///
    /// Example:
    /// ```swift
    /// let guid: RSS.GUID = "https://example.com/post/123"
    /// // Equivalent to: RSS.GUID.makeUnchecked("https://example.com/post/123", isPermaLink: true)
    /// ```
    public init(stringLiteral value: String) {
        self = RSS.GUID.makeUnchecked(value, isPermaLink: true)
    }
}
