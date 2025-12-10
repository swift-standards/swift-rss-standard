public import URI_Standard

extension RSS {
    /// RSS 2.0 Enclosure (media attachment)
    public struct Enclosure: Hashable, Sendable, Codable {
        public let url: URI
        public let length: Int  // bytes
        public let type: String  // MIME type

        public init(
            url: some URI.Representable,
            length: Int,
            type: String
        ) {
            self.url = url.uri
            self.length = length
            self.type = type
        }
    }
}

