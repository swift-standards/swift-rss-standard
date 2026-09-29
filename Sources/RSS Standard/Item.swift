public import RFC_5322
public import URI_Standard

extension RSS {

    public struct Item: Hashable, Sendable {

        public let title: String?
        public let description: String?

        public let link: URI?
        public let author: String?
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
        ) throws(Error) {

            guard title != nil || description != nil else {
                throw .itemRequiresTitleOrDescription
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
        ) throws(Error) {
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
