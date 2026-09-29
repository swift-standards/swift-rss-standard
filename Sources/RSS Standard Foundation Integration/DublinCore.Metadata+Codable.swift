public import RFC_5322
public import RSS_Standard_Dublin_Core
import RFC_5322_Foundation_Integration

extension DublinCore.Metadata: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case creator
        case subject
        case publisher
        case contributor
        case date
        case type
        case format
        case identifier
        case source
        case language
        case relation
        case coverage
        case rights
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            creator: try container.decodeIfPresent([String].self, forKey: .creator) ?? [],
            subject: try container.decodeIfPresent([String].self, forKey: .subject) ?? [],
            publisher: try container.decodeIfPresent(String.self, forKey: .publisher),
            contributor: try container.decodeIfPresent([String].self, forKey: .contributor) ?? [],
            date: try container.decodeIfPresent(RFC_5322.Date.self, forKey: .date),
            type: try container.decodeIfPresent(String.self, forKey: .type),
            format: try container.decodeIfPresent(String.self, forKey: .format),
            identifier: try container.decodeIfPresent(String.self, forKey: .identifier),
            source: try container.decodeIfPresent(String.self, forKey: .source),
            language: try container.decodeIfPresent(String.self, forKey: .language),
            relation: try container.decodeIfPresent(String.self, forKey: .relation),
            coverage: try container.decodeIfPresent(String.self, forKey: .coverage),
            rights: try container.decodeIfPresent(String.self, forKey: .rights)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(creator, forKey: .creator)
        try container.encode(subject, forKey: .subject)
        try container.encodeIfPresent(publisher, forKey: .publisher)
        try container.encode(contributor, forKey: .contributor)
        try container.encodeIfPresent(date, forKey: .date)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(format, forKey: .format)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(relation, forKey: .relation)
        try container.encodeIfPresent(coverage, forKey: .coverage)
        try container.encodeIfPresent(rights, forKey: .rights)
    }
}
