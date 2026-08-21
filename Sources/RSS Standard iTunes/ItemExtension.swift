import RSS_Standard
public import URI_Standard

extension iTunes {

    public struct ItemExtension: Hashable, Sendable, Codable {

        public let author: String?

        public let duration: Duration?

        public let explicit: Bool?

        public let episodeType: EpisodeType?

        public let season: Int?

        public let episode: Int?

        public let title: String?

        public let subtitle: String?

        public let summary: String?

        public let image: URI?

        public init(
            author: String? = nil,
            duration: Duration? = nil,
            explicit: Bool? = nil,
            episodeType: EpisodeType? = nil,
            season: Int? = nil,
            episode: Int? = nil,
            title: String? = nil,
            subtitle: String? = nil,
            summary: String? = nil,
            image: URI? = nil
        ) {
            self.author = author
            self.duration = duration
            self.explicit = explicit
            self.episodeType = episodeType
            self.season = season
            self.episode = episode
            self.title = title
            self.subtitle = subtitle
            self.summary = summary
            self.image = image
        }
    }
}
