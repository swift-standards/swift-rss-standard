extension iTunes {
    /// Podcast owner information
    public struct Owner: Hashable, Sendable, Codable {
        public let name: String
        public let email: String

        public init(name: String, email: String) {
            self.name = name
            self.email = email
        }
    }
}
