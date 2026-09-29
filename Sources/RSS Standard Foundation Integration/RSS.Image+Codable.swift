public import RSS_Standard
public import URI_Standard
import RFC_3986_Foundation_Integration

extension RSS.Image: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case url
        case title
        case link
        case width
        case height
        case description
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            url: try container.decode(URI.self, forKey: .url),
            title: try container.decode(String.self, forKey: .title),
            link: try container.decode(URI.self, forKey: .link),
            width: try container.decodeIfPresent(Int.self, forKey: .width),
            height: try container.decodeIfPresent(Int.self, forKey: .height),
            description: try container.decodeIfPresent(String.self, forKey: .description)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(title, forKey: .title)
        try container.encode(link, forKey: .link)
        try container.encodeIfPresent(width, forKey: .width)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(description, forKey: .description)
    }
}
