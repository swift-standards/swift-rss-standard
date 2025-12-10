import RSS_Standard
public import URI_Standard

extension iTunes {
    /// iTunes podcast item (episode) extensions
    public struct ItemExtension: Hashable, Sendable, Codable {
        /// The episode author
        public let author: String?

        /// The duration of the episode
        public let duration: Duration?

        /// Whether the episode contains explicit content
        public let explicit: Bool?

        /// The episode type
        public let episodeType: EpisodeType?

        /// The season number
        public let season: Int?

        /// The episode number
        public let episode: Int?

        /// Episode title (can differ from RSS item title)
        public let title: String?

        /// Episode subtitle
        public let subtitle: String?

        /// Episode summary
        public let summary: String?

        /// URI to episode-specific artwork
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

extension iTunes {
    /// Episode type
    public enum EpisodeType: String, Hashable, Sendable, Codable {
        case full
        case trailer
        case bonus
    }
}
