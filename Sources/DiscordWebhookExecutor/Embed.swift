import Foundation


public struct Embed: Codable {
    
    public let title: String?
    
    internal var type: String = "rich"
    
    public let description: String?
    
    public let url: URL?
    
    public let timestamp: Date?
    
    public let color: UInt?
    
    public let footer: EmbedFooter?
    
    public let image: EmbedImage?
    
    public let thumbnail: EmbedThumbnail?
    
    public let author: EmbedAuthor?
    
    public let fields: [EmbedField]?
    
    public init(
        title: String?,
        description: String?,
        url: URL?,
        timestamp: Date?,
        color: UInt?,
        footer: EmbedFooter?,
        image: EmbedImage?,
        thumbnail: EmbedThumbnail?,
        author: EmbedAuthor?,
        fields: [EmbedField]?
    ) {
        self.title = title
        self.description = description
        self.url = url
        self.timestamp = timestamp
        self.color = color
        self.footer = footer
        self.image = image
        self.thumbnail = thumbnail
        self.author = author
        self.fields = fields
    }
    
}


public struct EmbedFooter: Codable {
    
    public let text: String
    
    public let iconURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case text
        case iconURL = "icon_url"
    }
    
    public init(
        text: String,
        iconURL: URL?
    ) {
        self.text = text
        self.iconURL = iconURL
    }
    
}


public struct EmbedImage: Codable {
    
    public let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
}


public struct EmbedThumbnail: Codable {
    
    public let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
}


public struct EmbedAuthor: Codable {
    
    public let name: String
    
    public let url: URL?
    
    public let iconURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case iconURL = "icon_url"
    }
    
    public init(
        name: String,
        url: URL?,
        iconURL: URL?
    ) {
        self.name = name
        self.url = url
        self.iconURL = iconURL
    }
    
}


public struct EmbedField: Codable {
    
    public let name: String
    
    public let value: String
    
    public let inline: Bool?
    
    public init(
        name: String,
        value: String,
        inline: Bool?
    ) {
        self.name = name
        self.value = value
        self.inline = inline
    }
    
}
