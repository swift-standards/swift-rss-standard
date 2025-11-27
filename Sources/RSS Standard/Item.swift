public import URI_Standard
public import RFC_5322

extension RSS {
    /// RSS 2.0 Item (individual entry)
    public struct Item: Hashable, Sendable, Codable {
        // At least one of title or description required (validation in init)
        public let title: String?
        public let description: String?
        
        // Optional elements
        public let link: URI?
        public let author: String? // email
        public let categories: [Category]
        public let comments: URI?
        public let enclosure: Enclosure?
        public let guid: GUID?
        public let pubDate: RFC_5322.Date?
        public let source: Source?
        
        public init(
            title: String? = nil,
            description: String? = nil,
            link: URI? = nil,
            author: String? = nil,
            categories: [Category] = [],
            comments: URI? = nil,
            enclosure: Enclosure? = nil,
            guid: GUID? = nil,
            pubDate: RFC_5322.Date? = nil,
            source: Source? = nil
        ) throws {
            // Validation: at least one of title or description required
            guard title != nil || description != nil else {
                throw Error.itemRequiresTitleOrDescription
            }
            
            self.title = title
            self.description = description
            self.link = link
            self.author = author
            self.categories = categories
            self.comments = comments
            self.enclosure = enclosure
            self.guid = guid
            self.pubDate = pubDate
            self.source = source
        }
        
        static func makeUnchecked(
            title: String? = nil,
            description: String? = nil,
            link: URI? = nil,
            author: String? = nil,
            categories: [Category] = [],
            comments: URI? = nil,
            enclosure: Enclosure? = nil,
            guid: GUID? = nil,
            pubDate: RFC_5322.Date? = nil,
            source: Source? = nil
        ) -> Item {
            Item(
                title: title,
                description: description,
                link: link,
                author: author,
                categories: categories,
                comments: comments,
                enclosure: enclosure,
                guid: guid,
                pubDate: pubDate,
                source: source,
                unchecked: ()
            )
        }
        
        private init(
            title: String?,
            description: String?,
            link: URI?,
            author: String?,
            categories: [Category],
            comments: URI?,
            enclosure: Enclosure?,
            guid: GUID?,
            pubDate: RFC_5322.Date?,
            source: Source?,
            unchecked: Void
        ) {
            self.title = title
            self.description = description
            self.link = link
            self.author = author
            self.categories = categories
            self.comments = comments
            self.enclosure = enclosure
            self.guid = guid
            self.pubDate = pubDate
            self.source = source
        }

        /// Convenience initializer accepting URI.Representable types
        ///
        /// Accepts any URI.Representable type (e.g., URI) for link and comments.
        @_disfavoredOverload
        public init(
            title: String? = nil,
            description: String? = nil,
            link: (any URI.Representable)? = nil,
            author: String? = nil,
            categories: [Category] = [],
            comments: (any URI.Representable)? = nil,
            enclosure: Enclosure? = nil,
            guid: GUID? = nil,
            pubDate: RFC_5322.Date? = nil,
            source: Source? = nil
        ) throws {
            try self.init(
                title: title,
                description: description,
                link: link?.uri,
                author: author,
                categories: categories,
                comments: comments?.uri,
                enclosure: enclosure,
                guid: guid,
                pubDate: pubDate,
                source: source
            )
        }
    }
}
