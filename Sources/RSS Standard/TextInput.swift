import URI_Standard

extension RSS {
    /// RSS 2.0 TextInput
    public struct TextInput: Hashable, Sendable, Codable {
        public let title: String
        public let description: String
        public let name: String
        public let link: URI
        
        public init(title: String, description: String, name: String, link: URI) {
            self.title = title
            self.description = description
            self.name = name
            self.link = link
        }

        /// Convenience initializer accepting URI.Representable type
        ///
        /// Accepts any URI.Representable type (e.g., URI) for link.
        @_disfavoredOverload
        public init(title: String, description: String, name: String, link: any URI.Representable) {
            self.init(title: title, description: description, name: name, link: link.uri)
        }
    }
}
