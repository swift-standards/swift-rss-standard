import RSS_Standard
public import URI_Standard

extension iTunes {

    public struct ChannelExtension: Hashable, Sendable, Codable {

        public let author: String?

        public let owner: Owner?

        public let image: URI?

        public let categories: [Category]

        public let explicit: Bool?

        public let type: PodcastType?

        public let subtitle: String?

        public let summary: String?

        public let keywords: [String]?

        public init(
            author: String? = nil,
            owner: Owner? = nil,
            image: URI? = nil,
            categories: [Category] = [],
            explicit: Bool? = nil,
            type: PodcastType? = nil,
            subtitle: String? = nil,
            summary: String? = nil,
            keywords: [String]? = nil
        ) {
            self.author = author
            self.owner = owner
            self.image = image
            self.categories = categories
            self.explicit = explicit
            self.type = type
            self.subtitle = subtitle
            self.summary = summary
            self.keywords = keywords
        }
    }
}
