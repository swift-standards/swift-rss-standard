public import RSS_Standard
public import URI_Standard
import RFC_3986_Foundation_Integration

extension RSS.Enclosure: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case url
        case length
        case type
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            url: try container.decode(URI.self, forKey: .url),
            length: try container.decode(Int.self, forKey: .length),
            type: try container.decode(String.self, forKey: .type)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(length, forKey: .length)
        try container.encode(type, forKey: .type)
    }
}
