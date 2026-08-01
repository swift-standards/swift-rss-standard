extension iTunes {
    /// Episode type
    public enum EpisodeType: String, Hashable, Sendable, Codable {
        case full
        case trailer
        case bonus
    }
}
