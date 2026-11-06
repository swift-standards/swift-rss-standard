public import Domain_Standard
public import RFC_3986

extension RSS {

    public struct Cloud: Hashable, Sendable {
        public let domain: Domain
        public let port: Int
        public let path: RFC_3986.URI.Path
        public let registerProcedure: String
        public let `protocol`: `Protocol`

        @_disfavoredOverload
        public init(
            domain: Domain,
            port: Int,
            path: RFC_3986.URI.Path,
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
