extension RSS {
    public enum Error: Swift.Error, Sendable, Equatable {
        case itemRequiresTitleOrDescription
        case imageWidthExceedsMaximum(_ width: Int)
        case imageHeightExceedsMaximum(_ height: Int)
        case invalidPermalink(_ value: String)
    }
}
