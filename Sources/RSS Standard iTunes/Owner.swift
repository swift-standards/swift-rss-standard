public import RFC_5322

extension iTunes {

    public struct Owner: Hashable, Sendable {
        public let name: String
        public let email: RFC_5322.Mailbox

        public init(name: String, email: RFC_5322.Mailbox) {
            self.name = name
            self.email = email
        }
    }
}
