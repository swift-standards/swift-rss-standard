public import URI_Standard

extension RSS {

    public struct GUID: Hashable, Sendable {
        public let value: String
        public let isPermaLink: Bool

        public init(_ value: String, isPermaLink: Bool = true) throws(Error) {

            if isPermaLink {
                let uri: URI?
                do throws(URIError) {
                    uri = try URI(value)
                } catch {
                    uri = nil
                }
                guard let uri, uri.scheme != nil else {
                    throw Error.invalidPermalink(value)
                }
            }

            self.value = value
            self.isPermaLink = isPermaLink
        }

        public init(uri: URI) {
            self.value = uri.value
            self.isPermaLink = true
        }

        private init(_ value: String, _ isPermaLink: Bool, unchecked: Void) {
            self.value = value
            self.isPermaLink = isPermaLink
        }
    }
}

extension RSS.GUID {

    static func makeUnchecked(_ value: String, isPermaLink: Bool = true) -> RSS.GUID {
        RSS.GUID(value, isPermaLink, unchecked: ())
    }
}

extension RSS.GUID: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        self = RSS.GUID.makeUnchecked(value, isPermaLink: true)
    }
}
