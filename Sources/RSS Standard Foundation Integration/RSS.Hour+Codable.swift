public import RSS_Standard

extension RSS.Hour: Encodable, Decodable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        guard let hour = RSS.Hour(value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Hour must be 0-23, got \(value)"
            )
        }
        self = hour
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
