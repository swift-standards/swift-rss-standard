extension ITunes.Duration {
    public enum Error: Swift::Error, Sendable, Equatable {
        case tooManyComponents(_ count: Int)
        case invalidComponent(_ component: String)
    }
}
