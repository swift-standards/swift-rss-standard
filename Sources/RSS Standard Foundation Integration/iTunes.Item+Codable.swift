public import RSS_Standard_iTunes
public import URI_Standard
import RFC_3986_Foundation_Integration

extension iTunes.Item: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case author
        case duration
        case explicit
        case episodeType
        case season
        case episode
        case title
        case subtitle
        case summary
        case image
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            author: try container.decodeIfPresent(String.self, forKey: .author),
            duration: try container.decodeIfPresent(iTunes.Duration.self, forKey: .duration),
            explicit: try container.decodeIfPresent(Bool.self, forKey: .explicit),
            episodeType: try container.decodeIfPresent(
                iTunes.EpisodeType.self,
                forKey: .episodeType
            ),
            season: try container.decodeIfPresent(Int.self, forKey: .season),
            episode: try container.decodeIfPresent(Int.self, forKey: .episode),
            title: try container.decodeIfPresent(String.self, forKey: .title),
            subtitle: try container.decodeIfPresent(String.self, forKey: .subtitle),
            summary: try container.decodeIfPresent(String.self, forKey: .summary),
            image: try container.decodeIfPresent(URI.self, forKey: .image)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(explicit, forKey: .explicit)
        try container.encodeIfPresent(episodeType, forKey: .episodeType)
        try container.encodeIfPresent(season, forKey: .season)
        try container.encodeIfPresent(episode, forKey: .episode)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(subtitle, forKey: .subtitle)
        try container.encodeIfPresent(summary, forKey: .summary)
        try container.encodeIfPresent(image, forKey: .image)
    }
}
