extension RSS {

    public struct Hour: Hashable, Sendable, Comparable {
        public let value: Int

        public init?(_ value: Int) {
            guard (0...23).contains(value) else { return nil }
            self.value = value
        }
    }
}

extension RSS.Hour {
    public static func < (lhs: RSS.Hour, rhs: RSS.Hour) -> Bool {
        lhs.value < rhs.value
    }
}

extension RSS.Hour: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        guard let hour = RSS.Hour(value) else {
            fatalError("Hour must be 0-23, got \(value)")
        }
        self = hour
    }
}
