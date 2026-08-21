public import URI_Standard

extension RSS {

    public struct Image: Hashable, Sendable, Codable {
        public let url: URI
        public let title: String
        public let link: URI
        public let width: Int?
        public let height: Int?
        public let description: String?

        public init(
            url: URI,
            title: String,
            link: URI,
            width: Int? = nil,
            height: Int? = nil,
            description: String? = nil
        ) throws(Error) {
            if let width, width > 144 {
                throw .imageWidthExceedsMaximum(width)
            }
            if let height, height > 400 {
                throw .imageHeightExceedsMaximum(height)
            }

            self.url = url
            self.title = title
            self.link = link
            self.width = width
            self.height = height
            self.description = description
        }

        @_disfavoredOverload
        public init<U: URI.Representable, L: URI.Representable>(
            url: U,
            title: String,
            link: L,
            width: Int? = nil,
            height: Int? = nil,
            description: String? = nil
        ) throws(Error) {
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

extension RSS.Image {
    static func makeUnchecked(
        url: URI,
        title: String,
        link: URI,
        width: Int? = nil,
        height: Int? = nil,
        description: String? = nil
    ) -> RSS.Image {

        try! RSS.Image(
            url: url.uri,
            title: title,
            link: link,
            width: width,
            height: height,
            description: description
        )
    }
}
