extension RSS.Parse.Duration {
    public struct Output: Sendable, Equatable {
        public let hours: Int
        public let minutes: Int
        public let seconds: Int

        @inlinable
        public init(hours: Int, minutes: Int, seconds: Int) {
            self.hours = hours
            self.minutes = minutes
            self.seconds = seconds
        }
    }
}
