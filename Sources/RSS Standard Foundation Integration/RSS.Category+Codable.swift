public import RSS_Standard

extension RSS.Category: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case domain
        case value
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            domain: try container.decodeIfPresent(String.self, forKey: .domain),
            value: try container.decode(String.self, forKey: .value)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(domain, forKey: .domain)
        try container.encode(value, forKey: .value)
    }
}
