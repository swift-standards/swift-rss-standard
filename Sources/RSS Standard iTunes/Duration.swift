import Binary
import Radix_Formatter
import Standard_Library_Extensions

extension iTunes {

    public struct Duration: Hashable, Sendable, Codable {
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

        public init?(string: String) {
            let bytes = Array(string.utf8)
            var components: [String] = []
            var start = 0
            bytes.indices.forEach { idx in
                if bytes[idx] == 0x3A {
                    components.append(String(decoding: bytes[start..<idx], as: UTF8.self))
                    start = idx &+ 1
                }
            }
            components.append(String(decoding: bytes[start..<bytes.count], as: UTF8.self))

            switch components.count {
            case 1:
                guard let seconds = Int(components[0]) else { return nil }
                self.init(totalSeconds: seconds)

            case 2:
                guard let minutes = Int(components[0]),
                    let seconds = Int(components[1])
                else { return nil }
                self.init(hours: nil, minutes: minutes, seconds: seconds)

            case 3:
                guard let hours = Int(components[0]),
                    let minutes = Int(components[1]),
                    let seconds = Int(components[2])
                else { return nil }
                self.init(hours: hours, minutes: minutes, seconds: seconds)

            default:
                return nil
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
    public var totalSeconds: Int {
        (hours ?? 0) * 3600 + minutes * 60 + seconds
    }

    public var formatted: String {
        if let hours {
            let mm = minutes.formatted(.decimal.zeroPadded(width: 2))
            let ss = seconds.formatted(.decimal.zeroPadded(width: 2))
            return "\(hours):\(mm):\(ss)"
        } else {
            let ss = seconds.formatted(.decimal.zeroPadded(width: 2))
            return "\(minutes):\(ss)"
        }
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

extension iTunes.Duration: CustomStringConvertible {
    public var description: String {
        formatted
    }
}
