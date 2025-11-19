import RFC_3986

extension RSS {
    /// RSS 2.0 Enclosure (media attachment)
    public struct Enclosure: Hashable, Sendable, Codable {
        public let url: RFC_3986.URI
        public let length: Int // bytes
        public let type: String // MIME type
        
        public init(
            url: some RFC_3986.URI.Representable,
            length: Int,
            type: String
        ) {
            self.url = url.uri
            self.length = length
            self.type = type
        }
    }
}

//
//extension RSS.Enclosure {
//    /// Convenience initializer accepting URI.Representable type
//    ///
//    /// Accepts any RFC_3986.URI.Representable type (e.g., RFC_3986.URI) for url.
//    @_disfavoredOverload
//    public init(url: any RFC_3986.URI.Representable, length: Int, type: String) {
//        self.init(url: url.uri, length: length, type: type)
//    }
//}
