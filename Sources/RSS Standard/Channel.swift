public import RFC_5322
public import URI_Standard

extension RSS {

    public struct Channel: Hashable, Sendable, Codable {

        public let title: String
        public let link: URI
        public let description: String

        public let language: String?
        public let copyright: String?
        public let managingEditor: String?
        public let webMaster: String?
        public let pubDate: RFC_5322.Date?
        public let lastBuildDate: RFC_5322.Date?
        public let categories: [Category]
        public let generator: String?
        public let docs: URI?
        public let cloud: Cloud?
        public let ttl: Int?
        public let image: Image?
        public private(set) var rating: String?
        public let textInput: TextInput?
        public let skipHours: Set<Hour>?
        public let skipDays: [Weekday]?

        public let items: [Item]

        @_disfavoredOverload
        public init(
            title: String,
            link: URI,
            description: String,
            language: String? = nil,
            copyright: String? = nil,
            managingEditor: String? = nil,
            webMaster: String? = nil,
            pubDate: RFC_5322.Date? = nil,
            lastBuildDate: RFC_5322.Date? = nil,
            categories: [Category] = [],
            generator: String? = nil,
            docs: URI? = nil,
            cloud: Cloud? = nil,
            ttl: Int? = nil,
            image: Image? = nil,
            textInput: TextInput? = nil,
            skipHours: Set<Hour>? = nil,
            skipDays: [Weekday]? = nil,
            items: [Item] = []
        ) {
            self.title = title
            self.link = link
            self.description = description
            self.language = language
            self.copyright = copyright
            self.managingEditor = managingEditor
            self.webMaster = webMaster
            self.pubDate = pubDate
            self.lastBuildDate = lastBuildDate
            self.categories = categories
            self.generator = generator
            self.docs = docs
            self.cloud = cloud
            self.ttl = ttl
            self.image = image
            self.rating = nil
            self.textInput = textInput
            self.skipHours = skipHours
            self.skipDays = skipDays
            self.items = items
        }

        @_disfavoredOverload
        public init<L: URI.Representable>(
            title: String,
            link: L,
            description: String,
            language: String? = nil,
            copyright: String? = nil,
            managingEditor: String? = nil,
            webMaster: String? = nil,
            pubDate: RFC_5322.Date? = nil,
            lastBuildDate: RFC_5322.Date? = nil,
            categories: [Category] = [],
            generator: String? = nil,

            docs: (any URI.Representable)? = nil,
            cloud: Cloud? = nil,
            ttl: Int? = nil,
            image: Image? = nil,
            textInput: TextInput? = nil,
            skipHours: Set<Hour>? = nil,
            skipDays: [Weekday]? = nil,
            items: [Item] = []
        ) {
            self.init(
                title: title,
                link: link.uri,
                description: description,
                language: language,
                copyright: copyright,
                managingEditor: managingEditor,
                webMaster: webMaster,
                pubDate: pubDate,
                lastBuildDate: lastBuildDate,
                categories: categories,
                generator: generator,
                docs: docs?.uri,
                cloud: cloud,
                ttl: ttl,
                image: image,
                textInput: textInput,
                skipHours: skipHours,
                skipDays: skipDays,
                items: items
            )
        }
    }
}
