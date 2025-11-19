import RSS_Standard
import URI_Standard

extension iTunes {
    /// iTunes podcast channel extensions
    public struct ChannelExtension: Hashable, Sendable, Codable {
        /// The podcast author
        public let author: String?
        
        /// The podcast owner information
        public let owner: Owner?
        
        /// URI to podcast artwork (minimum 1400x1400, maximum 3000x3000 pixels)
        public let image: URI?
        
        /// Podcast categories
        public let categories: [Category]
        
        /// Whether the podcast contains explicit content
        public let explicit: Bool?
        
        /// The podcast type (episodic or serial)
        public let type: PodcastType?
        
        /// A subtitle for the podcast
        public let subtitle: String?
        
        /// A summary/description of the podcast
        public let summary: String?
        
        /// Keywords for the podcast
        public let keywords: [String]?
        
        public init(
            author: String? = nil,
            owner: Owner? = nil,
            image: URI? = nil,
            categories: [Category] = [],
            explicit: Bool? = nil,
            type: PodcastType? = nil,
            subtitle: String? = nil,
            summary: String? = nil,
            keywords: [String]? = nil
        ) {
            self.author = author
            self.owner = owner
            self.image = image
            self.categories = categories
            self.explicit = explicit
            self.type = type
            self.subtitle = subtitle
            self.summary = summary
            self.keywords = keywords
        }
    }
}

extension iTunes {
    /// Podcast type
    public enum PodcastType: String, Hashable, Sendable, Codable {
        case episodic
        case serial
    }
    
    /// Podcast owner information
    public struct Owner: Hashable, Sendable, Codable {
        public let name: String
        public let email: String
        
        public init(name: String, email: String) {
            self.name = name
            self.email = email
        }
    }
    
    /// iTunes category
    public struct Category: Hashable, Sendable, Codable {
        public let text: String
        public let subcategory: String?
        
        public init(text: String, subcategory: String? = nil) {
            self.text = text
            self.subcategory = subcategory
        }
    }
}
