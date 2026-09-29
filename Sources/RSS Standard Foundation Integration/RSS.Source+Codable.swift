public import RSS_Standard
public import URI_Standard
import RFC_3986_Foundation_Integration

extension RSS.Source: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case url
        case value
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            url: try container.decode(URI.self, forKey: .url),
            value: try container.decode(String.self, forKey: .value)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(value, forKey: .value)
    }
}
