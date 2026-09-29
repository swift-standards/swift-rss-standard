public import RSS_Standard_iTunes
public import URI_Standard
import RFC_3986_Foundation_Integration

extension iTunes.Channel: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case author
        case owner
        case image
        case categories
        case explicit
        case type
        case subtitle
        case summary
        case keywords
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            author: try container.decodeIfPresent(String.self, forKey: .author),
            owner: try container.decodeIfPresent(iTunes.Owner.self, forKey: .owner),
            image: try container.decodeIfPresent(URI.self, forKey: .image),
            categories: try container.decodeIfPresent([iTunes.Category].self, forKey: .categories)
                ?? [],
            explicit: try container.decodeIfPresent(Bool.self, forKey: .explicit),
            type: try container.decodeIfPresent(iTunes.PodcastType.self, forKey: .type),
            subtitle: try container.decodeIfPresent(String.self, forKey: .subtitle),
            summary: try container.decodeIfPresent(String.self, forKey: .summary),
            keywords: try container.decodeIfPresent([String].self, forKey: .keywords)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(owner, forKey: .owner)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encode(categories, forKey: .categories)
        try container.encodeIfPresent(explicit, forKey: .explicit)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(subtitle, forKey: .subtitle)
        try container.encodeIfPresent(summary, forKey: .summary)
        try container.encodeIfPresent(keywords, forKey: .keywords)
    }
}
