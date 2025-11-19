
extension RSS {
    /// Represents an hour in GMT (0-23) for RSS skipHours element
    public struct Hour: Hashable, Sendable, Comparable {
        public let value: Int

        /// Initialize with an hour value (0-23)
        public init?(_ value: Int) {
            guard (0...23).contains(value) else { return nil }
            self.value = value
        }

        public static func < (lhs: Hour, rhs: Hour) -> Bool {
            lhs.value < rhs.value
        }
    }
}

// MARK: - Codable
extension RSS.Hour: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

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
}

// MARK: - ExpressibleByIntegerLiteral
extension RSS.Hour: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        guard let hour = RSS.Hour(value) else {
            fatalError("Hour must be 0-23, got \(value)")
        }
        self = hour
    }
}
