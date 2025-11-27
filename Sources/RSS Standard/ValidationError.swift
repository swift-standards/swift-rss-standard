
extension RSS {
    public enum Error: Swift.Error, Sendable, Equatable {
        case itemRequiresTitleOrDescription
        case imageWidthExceedsMaximum(_ width: Int)
        case imageHeightExceedsMaximum(_ height: Int)
        case invalidXML(description: String)
        case invalidPermalink(_ value: String)

        public var errorDescription: String? {
            switch self {
            case .itemRequiresTitleOrDescription:
                return "RSS item requires at least one of title or description"
            case .imageWidthExceedsMaximum(let width):
                return "RSS image width \(width) exceeds maximum of 144 pixels"
            case .imageHeightExceedsMaximum(let height):
                return "RSS image height \(height) exceeds maximum of 400 pixels"
            case .invalidXML(let description):
                return "Invalid RSS XML: \(description)"
            case .invalidPermalink(let value):
                return "GUID permalink value '\(value)' is not a valid URI"
            }
        }
    }
}
