import RFC_3986

extension RSS {
    /// RSS 2.0 Channel (top-level feed container)
    public struct Channel: Hashable, Sendable, Codable {
        // Required elements
        public let title: String
        public let link: RFC_3986.URI
        public let description: String
        
        // Optional elements
        public let language: String?
        public let copyright: String?
        public let managingEditor: String? // email
        public let webMaster: String? // email
        public let pubDate: Date?
        public let lastBuildDate: Date?
        public let categories: [Category]
        public let generator: String?
        public let docs: RFC_3986.URI?
        public let cloud: Cloud?
        public let ttl: Int? // minutes
        public let image: Image?
        public private(set) var rating: String?
        public let textInput: TextInput?
        public let skipHours: Set<Hour>?
        public let skipDays: [Weekday]?
        
        // Items
        public let items: [Item]
        
        @_disfavoredOverload
        public init(
            title: String,
            link: RFC_3986.URI,
            description: String,
            language: String? = nil,
            copyright: String? = nil,
            managingEditor: String? = nil,
            webMaster: String? = nil,
            pubDate: Date? = nil,
            lastBuildDate: Date? = nil,
            categories: [Category] = [],
            generator: String? = nil,
            docs: RFC_3986.URI? = nil,
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

        /// Convenience initializer accepting URI.Representable types
        ///
        /// Accepts any RFC_3986.URI.Representable type (e.g., RFC_3986.URI) for link and docs.
        @_disfavoredOverload
        public init(
            title: String,
            link: any RFC_3986.URI.Representable,
            description: String,
            language: String? = nil,
            copyright: String? = nil,
            managingEditor: String? = nil,
            webMaster: String? = nil,
            pubDate: Date? = nil,
            lastBuildDate: Date? = nil,
            categories: [Category] = [],
            generator: String? = nil,
            docs: (any RFC_3986.URI.Representable)? = nil,
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
