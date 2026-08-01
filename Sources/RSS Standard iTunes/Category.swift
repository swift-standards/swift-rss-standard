extension iTunes {
    /// iTunes category
    public struct Category: Hashable, Sendable, Codable {
        public let text: String
        public let subcategory: String?

        public init(text: String, subcategory: String? = nil) {
            self.text = text
            self.subcategory = subcategory
        }
    }
}
