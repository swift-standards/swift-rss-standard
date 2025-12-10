extension RSS {
    /// RSS 2.0 Cloud (publish-subscribe)
    public struct Cloud: Hashable, Sendable, Codable {
        public let domain: String
        public let port: Int
        public let path: String
        public let registerProcedure: String
        public let `protocol`: CloudProtocol

        @_disfavoredOverload
        public init(
            domain: String,
            port: Int,
            path: String,
            registerProcedure: String,
            protocol: CloudProtocol
        ) {
            self.domain = domain
            self.port = port
            self.path = path
            self.registerProcedure = registerProcedure
            self.protocol = `protocol`
        }
    }
}
