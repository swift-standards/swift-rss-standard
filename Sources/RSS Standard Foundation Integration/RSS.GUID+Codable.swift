public import RSS_Standard

extension RSS.GUID: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case value
        case isPermaLink
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            try container.decode(String.self, forKey: .value),
            isPermaLink: try container.decodeIfPresent(Bool.self, forKey: .isPermaLink) ?? true
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(isPermaLink, forKey: .isPermaLink)
    }
}
