public import URI_Standard

extension RSS {

    public struct Enclosure: Hashable, Sendable, Codable {
        public let url: URI
        public let length: Int
        public let type: String

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
