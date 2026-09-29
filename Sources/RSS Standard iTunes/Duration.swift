extension iTunes {

    public struct Duration: Hashable, Sendable {
        public let hours: Int?
        public let minutes: Int
        public let seconds: Int

        public init(hours: Int? = nil, minutes: Int, seconds: Int) {
            self.hours = hours
            self.minutes = minutes
            self.seconds = seconds
        }

        public init(totalSeconds: Int) {
            self.hours = totalSeconds >= 3600 ? totalSeconds / 3600 : nil
            self.minutes = (totalSeconds % 3600) / 60
            self.seconds = totalSeconds % 60
        }

        public init(_ value: String) throws(Error) {
            let components = value.utf8.split(separator: 0x3A, omittingEmptySubsequences: false)
            guard components.count <= 3 else { throw .tooManyComponents(components.count) }
            let numbers = try components.map { (component: Substring.UTF8View) throws(Error) -> Int in
                try Self.number(component)
            }
            self = switch numbers.count {
            case 1: Self(totalSeconds: numbers[0])
            case 2: Self(minutes: numbers[0], seconds: numbers[1])
            default: Self(hours: numbers[0], minutes: numbers[1], seconds: numbers[2])
            }
        }

        @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
        public init(_ duration: Swift.Duration) {
            let totalSeconds = Int(duration.components.seconds)
            self.init(totalSeconds: totalSeconds)
        }
    }
}

extension iTunes.Duration {
    private static func number(_ component: Substring.UTF8View) throws(Error) -> Int {
        guard !component.isEmpty, component.allSatisfy({ (0x30...0x39).contains($0) }) else {
            throw .invalidComponent(String(decoding: component, as: UTF8.self))
        }
        return component.reduce(0) { (total: Int, byte: UInt8) in total &* 10 &+ Int(byte &- 0x30) }
    }
}

extension iTunes.Duration {
    public var totalSeconds: Int {
        (hours ?? 0) * 3600 + minutes * 60 + seconds
    }

    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    public var swiftDuration: Swift.Duration {
        .seconds(self.totalSeconds)
    }
}

extension iTunes.Duration: ExpressibleByIntegerLiteral {

    public init(integerLiteral value: Int) {
        self.init(totalSeconds: value)
    }
}
