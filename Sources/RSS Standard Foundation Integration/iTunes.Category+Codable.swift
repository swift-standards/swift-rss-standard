public import RSS_Standard_iTunes

extension iTunes.Category: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case text
        case subcategory
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            text: try container.decode(String.self, forKey: .text),
            subcategory: try container.decodeIfPresent(String.self, forKey: .subcategory)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encodeIfPresent(subcategory, forKey: .subcategory)
    }
}
