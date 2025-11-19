import URI_Standard

extension RSS {
    /// RSS 2.0 Source (original channel for syndicated content)
    public struct Source: Hashable, Sendable, Codable {
        public let url: URI
        public let value: String // channel title
        
        public init(url: URI, value: String) {
            self.url = url
            self.value = value
        }

        /// Convenience initializer accepting URI.Representable type
        ///
        /// Accepts any URI.Representable type (e.g., URI) for url.
        @_disfavoredOverload
        public init(url: any URI.Representable, value: String) {
            self.init(url: url.uri, value: value)
        }
    }
}
