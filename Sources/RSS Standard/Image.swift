public import URI_Standard

extension RSS {
    /// RSS 2.0 Image
    public struct Image: Hashable, Sendable, Codable {
        public let url: URI
        public let title: String
        public let link: URI
        public let width: Int?  // max 144, default 88
        public let height: Int?  // max 400, default 31
        public let description: String?

        public init(
            url: URI,
            title: String,
            link: URI,
            width: Int? = nil,
            height: Int? = nil,
            description: String? = nil
        ) throws {
            if let width = width, width > 144 {
                throw Error.imageWidthExceedsMaximum(width)
            }
            if let height = height, height > 400 {
                throw Error.imageHeightExceedsMaximum(height)
            }

            self.url = url
            self.title = title
            self.link = link
            self.width = width
            self.height = height
            self.description = description
        }

        static func makeUnchecked(
            url: URI,
            title: String,
            link: URI,
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
        /// Accepts any URI.Representable type (e.g., URI) for url and link.
        @_disfavoredOverload
        public init(
            url: any URI.Representable,
            title: String,
            link: any URI.Representable,
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
