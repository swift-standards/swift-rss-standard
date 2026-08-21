public import RFC_5322

extension DublinCore {

    public struct Metadata: Hashable, Sendable, Codable {

        public let creator: [String]

        public let subject: [String]

        public let publisher: String?

        public let contributor: [String]

        public let date: RFC_5322.Date?

        public let type: String?

        public let format: String?

        public let identifier: String?

        public let source: String?

        public let language: String?

        public let relation: String?

        public let coverage: String?

        public let rights: String?

        public init(
            creator: [String] = [],
            subject: [String] = [],
            publisher: String? = nil,
            contributor: [String] = [],
            date: RFC_5322.Date? = nil,
            type: String? = nil,
            format: String? = nil,
            identifier: String? = nil,
            source: String? = nil,
            language: String? = nil,
            relation: String? = nil,
            coverage: String? = nil,
            rights: String? = nil
        ) {
            self.creator = creator
            self.subject = subject
            self.publisher = publisher
            self.contributor = contributor
            self.date = date
            self.type = type
            self.format = format
            self.identifier = identifier
            self.source = source
            self.language = language
            self.relation = relation
            self.coverage = coverage
            self.rights = rights
        }
    }
}
