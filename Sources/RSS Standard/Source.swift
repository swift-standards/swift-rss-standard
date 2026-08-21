public import URI_Standard

extension RSS {

    public struct Source: Hashable, Sendable, Codable {
        public let url: URI
        public let value: String

        public init(url: URI, value: String) {
            self.url = url
            self.value = value
        }

        @_disfavoredOverload
        public init<T: URI.Representable>(url: T, value: String) {
            self.init(url: url.uri, value: value)
        }
    }
}
