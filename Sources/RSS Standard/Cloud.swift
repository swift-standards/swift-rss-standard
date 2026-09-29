extension RSS {

    public struct Cloud: Hashable, Sendable {
        public let domain: String
        public let port: Int
        public let path: String
        public let registerProcedure: String
        public let `protocol`: `Protocol`

        @_disfavoredOverload
        public init(
            domain: String,
            port: Int,
            path: String,
            registerProcedure: String,
            protocol: `Protocol`
        ) {
            self.domain = domain
            self.port = port
            self.path = path
            self.registerProcedure = registerProcedure
            self.protocol = `protocol`
        }
    }
}
