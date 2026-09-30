public import RSS_Standard

private typealias CloudProtocol = RSS.Cloud.`Protocol`

extension RSS.Cloud: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case domain
        case port
        case path
        case registerProcedure
        case `protocol`
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            domain: try container.decode(String.self, forKey: .domain),
            port: try container.decode(Int.self, forKey: .port),
            path: try container.decode(String.self, forKey: .path),
            registerProcedure: try container.decode(String.self, forKey: .registerProcedure),
            protocol: try container.decode(CloudProtocol.self, forKey: .protocol)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(domain, forKey: .domain)
        try container.encode(port, forKey: .port)
        try container.encode(path, forKey: .path)
        try container.encode(registerProcedure, forKey: .registerProcedure)
        try container.encode(self.protocol, forKey: .protocol)
    }
}
