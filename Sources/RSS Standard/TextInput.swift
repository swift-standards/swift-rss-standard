public import URI_Standard

extension RSS {

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

        @_disfavoredOverload
        public init<T: URI.Representable>(title: String, description: String, name: String, link: T)
        {
            self.init(title: title, description: description, name: name, link: link.uri)
        }
    }
}
