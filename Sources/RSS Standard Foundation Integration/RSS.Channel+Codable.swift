public import RFC_5322
public import RSS_Standard
public import URI_Standard
import RFC_3986_Foundation_Integration
import RFC_5322_Foundation_Integration

extension RSS.Channel: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case description
        case language
        case copyright
        case managingEditor
        case webMaster
        case pubDate
        case lastBuildDate
        case categories
        case generator
        case docs
        case cloud
        case ttl
        case image
        case textInput
        case skipHours
        case skipDays
        case items
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            title: try container.decode(String.self, forKey: .title),
            link: try container.decode(URI.self, forKey: .link),
            description: try container.decode(String.self, forKey: .description),
            language: try container.decodeIfPresent(String.self, forKey: .language),
            copyright: try container.decodeIfPresent(String.self, forKey: .copyright),
            managingEditor: try container.decodeIfPresent(String.self, forKey: .managingEditor),
            webMaster: try container.decodeIfPresent(String.self, forKey: .webMaster),
            pubDate: try container.decodeIfPresent(RFC_5322.Date.self, forKey: .pubDate),
            lastBuildDate: try container.decodeIfPresent(
                RFC_5322.Date.self,
                forKey: .lastBuildDate
            ),
            categories: try container.decodeIfPresent([RSS.Category].self, forKey: .categories)
                ?? [],
            generator: try container.decodeIfPresent(String.self, forKey: .generator),
            docs: try container.decodeIfPresent(URI.self, forKey: .docs),
            cloud: try container.decodeIfPresent(RSS.Cloud.self, forKey: .cloud),
            ttl: try container.decodeIfPresent(Int.self, forKey: .ttl),
            image: try container.decodeIfPresent(RSS.Image.self, forKey: .image),
            textInput: try container.decodeIfPresent(RSS.TextInput.self, forKey: .textInput),
            skipHours: try container.decodeIfPresent(Set<RSS.Hour>.self, forKey: .skipHours),
            skipDays: try container.decodeIfPresent([RSS.Weekday].self, forKey: .skipDays),
            items: try container.decodeIfPresent([RSS.Item].self, forKey: .items) ?? []
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(link, forKey: .link)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(copyright, forKey: .copyright)
        try container.encodeIfPresent(managingEditor, forKey: .managingEditor)
        try container.encodeIfPresent(webMaster, forKey: .webMaster)
        try container.encodeIfPresent(pubDate, forKey: .pubDate)
        try container.encodeIfPresent(lastBuildDate, forKey: .lastBuildDate)
        try container.encode(categories, forKey: .categories)
        try container.encodeIfPresent(generator, forKey: .generator)
        try container.encodeIfPresent(docs, forKey: .docs)
        try container.encodeIfPresent(cloud, forKey: .cloud)
        try container.encodeIfPresent(ttl, forKey: .ttl)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(textInput, forKey: .textInput)
        try container.encodeIfPresent(skipHours, forKey: .skipHours)
        try container.encodeIfPresent(skipDays, forKey: .skipDays)
        try container.encode(items, forKey: .items)
    }
}
