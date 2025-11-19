
extension iTunes {
    /// Duration in hours, minutes, and seconds for podcast episodes
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
        
        public var totalSeconds: Int {
            (hours ?? 0) * 3600 + minutes * 60 + seconds
        }
        
        public var formatted: String {
            if let hours = hours {
                return String(format: "%d:%02d:%02d", hours, minutes, seconds)
            } else {
                return String(format: "%d:%02d", minutes, seconds)
            }
        }
        
        /// Parse duration from string (format: HH:MM:SS or MM:SS or SS)
        public init?(string: String) {
            let components = string.split(separator: ":").map(String.init)

            switch components.count {
            case 1:
                // Just seconds
                guard let seconds = Int(components[0]) else { return nil }
                self.init(totalSeconds: seconds)

            case 2:
                // MM:SS
                guard let minutes = Int(components[0]),
                      let seconds = Int(components[1]) else { return nil }
                self.init(hours: nil, minutes: minutes, seconds: seconds)

            case 3:
                // HH:MM:SS
                guard let hours = Int(components[0]),
                      let minutes = Int(components[1]),
                      let seconds = Int(components[2]) else { return nil }
                self.init(hours: hours, minutes: minutes, seconds: seconds)

            default:
                return nil
            }
        }

        /// Convert from Swift.Duration to iTunes.Duration
        ///
        /// Example:
        /// ```swift
        /// let duration = iTunes.Duration(.seconds(3665))
        /// ```
        @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
        public init(_ duration: Swift.Duration) {
            let totalSeconds = Int(duration.components.seconds)
            self.init(totalSeconds: totalSeconds)
        }

        /// Convert to Swift.Duration
        ///
        /// Example:
        /// ```swift
        /// let swiftDuration = itunesDuration.swiftDuration
        /// ```
        @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
        public var swiftDuration: Swift.Duration {
            .seconds(self.totalSeconds)
        }
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension iTunes.Duration: ExpressibleByIntegerLiteral {
    /// Creates a duration from an integer literal representing total seconds
    ///
    /// Example:
    /// ```swift
    /// let duration: iTunes.Duration = 3665  // 1:01:05
    /// ```
    public init(integerLiteral value: Int) {
        self.init(totalSeconds: value)
    }
}

// MARK: - CustomStringConvertible
extension iTunes.Duration: CustomStringConvertible {
    public var description: String {
        formatted
    }
}
