public import RSS_Standard_iTunes

extension iTunes.EpisodeType: Encodable, Decodable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let episodeType = iTunes.EpisodeType(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Episode type must be full, trailer or bonus, got \(rawValue)"
            )
        }
        self = episodeType
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
