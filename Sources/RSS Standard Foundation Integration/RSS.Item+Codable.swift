public import RFC_5322
public import RSS_Standard
public import URI_Standard
import RFC_3986_Foundation_Integration
import RFC_5322_Foundation_Integration

extension RSS.Item: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case link
        case author
        case categories
        case comments
        case enclosure
        case guid
        case pubDate
        case source
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            title: try container.decodeIfPresent(String.self, forKey: .title),
            description: try container.decodeIfPresent(String.self, forKey: .description),
            link: try container.decodeIfPresent(URI.self, forKey: .link),
            author: try container.decodeIfPresent(String.self, forKey: .author),
            categories: try container.decodeIfPresent([RSS.Category].self, forKey: .categories)
                ?? [],
            comments: try container.decodeIfPresent(URI.self, forKey: .comments),
            enclosure: try container.decodeIfPresent(RSS.Enclosure.self, forKey: .enclosure),
            guid: try container.decodeIfPresent(RSS.GUID.self, forKey: .guid),
            pubDate: try container.decodeIfPresent(RFC_5322.Date.self, forKey: .pubDate),
            source: try container.decodeIfPresent(RSS.Source.self, forKey: .source)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(link, forKey: .link)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encode(categories, forKey: .categories)
        try container.encodeIfPresent(comments, forKey: .comments)
        try container.encodeIfPresent(enclosure, forKey: .enclosure)
        try container.encodeIfPresent(guid, forKey: .guid)
        try container.encodeIfPresent(pubDate, forKey: .pubDate)
        try container.encodeIfPresent(source, forKey: .source)
    }
}
