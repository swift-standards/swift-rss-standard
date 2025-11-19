import RFC_3986

extension RSS {
    /// RSS 2.0 Image
    public struct Image: Hashable, Sendable, Codable {
        public let url: RFC_3986.URI
        public let title: String
        public let link: RFC_3986.URI
        public let width: Int? // max 144, default 88
        public let height: Int? // max 400, default 31
        public let description: String?
        
        public init(
            url: RFC_3986.URI,
            title: String,
            link: RFC_3986.URI,
            width: Int? = nil,
            height: Int? = nil,
            description: String? = nil
        ) throws {
            if let width = width, width > 144 {
                throw ValidationError.imageWidthExceedsMaximum(width)
            }
            if let height = height, height > 400 {
                throw ValidationError.imageHeightExceedsMaximum(height)
            }
            
            self.url = url
            self.title = title
            self.link = link
            self.width = width
            self.height = height
            self.description = description
        }
        
        static func makeUnchecked(
            url: RFC_3986.URI,
            title: String,
            link: RFC_3986.URI,
            width: Int? = nil,
            height: Int? = nil,
            description: String? = nil
        ) -> Image {
            try! Image(
                url: url.uri,
                title: title,
                link: link,
                width: width,
                height: height,
                description: description
            )
        }
        /// Convenience initializer accepting URI.Representable types
        ///
        /// Accepts any RFC_3986.URI.Representable type (e.g., RFC_3986.URI) for url and link.
        @_disfavoredOverload
        public init(
            url: any RFC_3986.URI.Representable,
            title: String,
            link: any RFC_3986.URI.Representable,
            width: Int? = nil,
            height: Int? = nil,
            description: String? = nil
        ) throws {
            try self.init(
                url: url.uri,
                title: title,
                link: link.uri,
                width: width,
                height: height,
                description: description
            )
        }
    }
}
