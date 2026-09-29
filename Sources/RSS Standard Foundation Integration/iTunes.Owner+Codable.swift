public import RFC_5322
public import RSS_Standard_iTunes
import RFC_5322_Foundation_Integration

extension iTunes.Owner: Encodable, Decodable {

    enum CodingKeys: String, CodingKey {
        case name
        case email
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            name: try container.decode(String.self, forKey: .name),
            email: try container.decode(RFC_5322.Mailbox.self, forKey: .email)
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
    }
}
