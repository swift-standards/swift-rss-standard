public import RSS_Standard
public import URI_Standard
import RFC_3986_Foundation_Integration

extension RSS.TextInput: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case name
        case link
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            title: try container.decode(String.self, forKey: .title),
            description: try container.decode(String.self, forKey: .description),
            name: try container.decode(String.self, forKey: .name),
            link: try container.decode(URI.self, forKey: .link)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(name, forKey: .name)
        try container.encode(link, forKey: .link)
    }
}
