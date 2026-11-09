import Domain_Standard
import RFC_3986
import RFC_5322
import RFC_5646
public import RSS_Standard
import URI_Standard
public import W3C_XML

extension W3C_XML.Document {
    public init(_ channel: RSS.Channel) {
        self.init(
            declaration: W3C_XML.Declaration(version: .v1_0, encoding: "UTF-8"),
            root: W3C_XML.Element(name: "rss", attributes: [W3C_XML.Attribute(name: "version", value: "2.0")], content: [.element(W3C_XML.Element(channel))])
        )
    }
}

extension W3C_XML.Element {
    public init(_ channel: RSS.Channel) {
        var content: [W3C_XML.Content] = [
            .element(.init(rss: "title", channel.title)),
            .element(.init(rss: "link", channel.link.value)),
            .element(.init(rss: "description", channel.description)),
        ]
        content += [
            channel.language.map { W3C_XML.Element(rss: "language", $0.description) },
            channel.copyright.map { W3C_XML.Element(rss: "copyright", $0) },
            channel.managingEditor.map { W3C_XML.Element(rss: "managingEditor", $0) },
            channel.webMaster.map { W3C_XML.Element(rss: "webMaster", $0) },
            channel.pubDate.map { W3C_XML.Element(rss: "pubDate", $0.description) },
            channel.lastBuildDate.map { W3C_XML.Element(rss: "lastBuildDate", $0.description) },
        ].compactMap { $0.map(W3C_XML.Content.element) }
        content += channel.categories.map { .element(W3C_XML.Element($0)) }
        content += [
            channel.generator.map { W3C_XML.Element(rss: "generator", $0) },
            channel.docs.map { W3C_XML.Element(rss: "docs", $0.value) },
            channel.cloud.map(W3C_XML.Element.init),
            channel.ttl.map { W3C_XML.Element(rss: "ttl", "\($0)") },
            channel.image.map(W3C_XML.Element.init),
            channel.textInput.map(W3C_XML.Element.init),
            channel.skipHours.map { hours in
                W3C_XML.Element(name: "skipHours", content: hours.sorted().map { .element(W3C_XML.Element(rss: "hour", "\($0.value)")) })
            },
            channel.skipDays.map { days in
                W3C_XML.Element(name: "skipDays", content: days.map { .element(W3C_XML.Element(rss: "day", $0.rawValue)) })
            },
        ].compactMap { $0.map(W3C_XML.Content.element) }
        content += channel.items.map { .element(W3C_XML.Element($0)) }
        self.init(name: "channel", content: content)
    }

    public init(_ item: RSS.Item) {
        var content: [W3C_XML.Content] = [
            item.title.map { W3C_XML.Element(rss: "title", $0) },
            item.link.map { W3C_XML.Element(rss: "link", $0.value) },
            item.description.map { W3C_XML.Element(rss: "description", $0) },
            item.author.map { W3C_XML.Element(rss: "author", $0) },
        ].compactMap { $0.map(W3C_XML.Content.element) }
        content += item.categories.map { .element(W3C_XML.Element($0)) }
        content += [
            item.comments.map { W3C_XML.Element(rss: "comments", $0.value) },
            item.enclosure.map(W3C_XML.Element.init),
            item.guid.map(W3C_XML.Element.init),
            item.pubDate.map { W3C_XML.Element(rss: "pubDate", $0.description) },
            item.source.map(W3C_XML.Element.init),
        ].compactMap { $0.map(W3C_XML.Content.element) }
        self.init(name: "item", content: content)
    }

    public init(_ category: RSS.Category) {
        self.init(
            name: "category",
            attributes: category.domain.map { [W3C_XML.Attribute(name: "domain", value: $0.value)] } ?? [],
            content: [.text(category.value)]
        )
    }

    public init(_ guid: RSS.GUID) {
        self.init(
            name: "guid",
            attributes: [W3C_XML.Attribute(name: "isPermaLink", value: guid.isPermaLink ? "true" : "false")],
            content: [.text(guid.value)]
        )
    }

    public init(_ enclosure: RSS.Enclosure) {
        self.init(
            name: "enclosure",
            attributes: [
                W3C_XML.Attribute(name: "url", value: enclosure.url.value),
                W3C_XML.Attribute(name: "length", value: "\(enclosure.length)"),
                W3C_XML.Attribute(name: "type", value: enclosure.type),
            ]
        )
    }

    public init(_ source: RSS.Source) {
        self.init(name: "source", attributes: [W3C_XML.Attribute(name: "url", value: source.url.value)], content: [.text(source.value)])
    }

    public init(_ image: RSS.Image) {
        let content: [W3C_XML.Element?] = [
            W3C_XML.Element(rss: "url", image.url.value),
            W3C_XML.Element(rss: "title", image.title),
            W3C_XML.Element(rss: "link", image.link.value),
            image.width.map { W3C_XML.Element(rss: "width", "\($0)") },
            image.height.map { W3C_XML.Element(rss: "height", "\($0)") },
            image.description.map { W3C_XML.Element(rss: "description", $0) },
        ]
        self.init(name: "image", content: content.compactMap { $0.map(W3C_XML.Content.element) })
    }

    public init(_ cloud: RSS.Cloud) {
        self.init(
            name: "cloud",
            attributes: [
                W3C_XML.Attribute(name: "domain", value: cloud.domain.description),
                W3C_XML.Attribute(name: "port", value: "\(cloud.port)"),
                W3C_XML.Attribute(name: "path", value: "\(cloud.path)"),
                W3C_XML.Attribute(name: "registerProcedure", value: cloud.registerProcedure),
                W3C_XML.Attribute(name: "protocol", value: cloud.protocol.rawValue),
            ]
        )
    }

    public init(_ input: RSS.TextInput) {
        self.init(
            name: "textInput",
            content: [
                .element(W3C_XML.Element(rss: "title", input.title)),
                .element(W3C_XML.Element(rss: "description", input.description)),
                .element(W3C_XML.Element(rss: "name", input.name)),
                .element(W3C_XML.Element(rss: "link", input.link.value)),
            ]
        )
    }

    init(rss name: String, _ text: String) {
        self.init(name: name, content: [.text(text)])
    }
}
