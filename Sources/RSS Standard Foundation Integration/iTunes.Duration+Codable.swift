public import RSS_Standard_iTunes

extension iTunes.Duration: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case hours
        case minutes
        case seconds
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            hours: try container.decodeIfPresent(Int.self, forKey: .hours),
            minutes: try container.decode(Int.self, forKey: .minutes),
            seconds: try container.decode(Int.self, forKey: .seconds)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(hours, forKey: .hours)
        try container.encode(minutes, forKey: .minutes)
        try container.encode(seconds, forKey: .seconds)
    }
}
