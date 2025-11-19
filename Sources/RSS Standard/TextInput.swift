import RFC_3986

extension RSS {
    /// RSS 2.0 TextInput
    public struct TextInput: Hashable, Sendable, Codable {
        public let title: String
        public let description: String
        public let name: String
        public let link: RFC_3986.URI
        
        public init(title: String, description: String, name: String, link: RFC_3986.URI) {
            self.title = title
            self.description = description
            self.name = name
            self.link = link
        }

        /// Convenience initializer accepting URI.Representable type
        ///
        /// Accepts any RFC_3986.URI.Representable type (e.g., RFC_3986.URI) for link.
        @_disfavoredOverload
        public init(title: String, description: String, name: String, link: any RFC_3986.URI.Representable) {
            self.init(title: title, description: description, name: name, link: link.uri)
        }
    }
}
