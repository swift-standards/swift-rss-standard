public import RFC_5322

extension DublinCore {
    /// Dublin Core metadata elements
    /// Based on Dublin Core Metadata Element Set, Version 1.1
    public struct Metadata: Hashable, Sendable, Codable {
        /// An entity primarily responsible for making the resource (can have multiple)
        public let creator: [String]

        /// The topic of the resource (can have multiple)
        public let subject: [String]

        /// An entity responsible for making the resource available
        public let publisher: String?

        /// An entity responsible for making contributions to the resource (can have multiple)
        public let contributor: [String]

        /// A point or period of time associated with an event in the lifecycle of the resource
        public let date: RFC_5322.Date?

        /// The nature or genre of the resource
        public let type: String?

        /// The file format, physical medium, or dimensions of the resource
        public let format: String?

        /// An unambiguous reference to the resource within a given context
        public let identifier: String?

        /// A related resource from which the described resource is derived
        public let source: String?

        /// A language of the resource (RFC 4646)
        public let language: String?

        /// A related resource
        public let relation: String?

        /// The spatial or temporal topic of the resource
        public let coverage: String?

        /// Information about rights held in and over the resource
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
