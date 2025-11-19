import RFC_3986

extension RSS {
    /// RSS 2.0 Source (original channel for syndicated content)
    public struct Source: Hashable, Sendable, Codable {
        public let url: RFC_3986.URI
        public let value: String // channel title
        
        public init(url: RFC_3986.URI, value: String) {
            self.url = url
            self.value = value
        }

        /// Convenience initializer accepting URI.Representable type
        ///
        /// Accepts any RFC_3986.URI.Representable type (e.g., RFC_3986.URI) for url.
        @_disfavoredOverload
        public init(url: any RFC_3986.URI.Representable, value: String) {
            self.init(url: url.uri, value: value)
        }
    }
}
