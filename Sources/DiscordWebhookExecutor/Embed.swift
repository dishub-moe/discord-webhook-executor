import Foundation


public struct Embed: Codable {
    
    public let title: String?
    
    public let type: EmbedType
    
    public let description: String?
    
    public let url: URL?
    
    public let timestamp: Date?
    
    public let color: UInt?
    
    public let footer: EmbedFooter?
    
    public let image: EmbedImage?
    
    public let thumbnail: EmbedThumbnail?
    
    public let video: EmbedVideo?
    
    public let provider: EmbedProvider?
    
    public let author: EmbedAuthor?
    
    public let fields: [EmbedField]?
    
    public init(
        title: String?,
        type: EmbedType,
        description: String?,
        url: URL?,
        timestamp: Date?,
        color: UInt?,
        footer: EmbedFooter?,
        image: EmbedImage?,
        thumbnail: EmbedThumbnail?,
        video: EmbedVideo?,
        provider: EmbedProvider?,
        author: EmbedAuthor?,
        fields: [EmbedField]?
    ) {
        self.title = title
        self.type = type
        self.description = description
        self.url = url
        self.timestamp = timestamp
        self.color = color
        self.footer = footer
        self.image = image
        self.thumbnail = thumbnail
        self.video = video
        self.provider = provider
        self.author = author
        self.fields = fields
    }
    
}


public enum EmbedType: String, Codable {
    
    case rich = "rich"
    
}


public struct EmbedFooter: Codable {
    
    public let text: String
    
    public let iconURL: URL?
    
    public let proxyIconURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case text
        case iconURL = "icon_url"
        case proxyIconURL = "proxy_icon_url"
    }
    
    public init(
        text: String,
        iconURL: URL?,
        proxyIconURL: URL?
    ) {
        self.text = text
        self.iconURL = iconURL
        self.proxyIconURL = proxyIconURL
    }
    
}


public struct EmbedImage: Codable {
    
    public let url: URL
    
    public let proxyURL: URL?
    
    public let height: UInt?
    
    public let width: UInt?
    
    enum CodingKeys: String, CodingKey {
        case url
        case proxyURL = "proxy_url"
        case height
        case width
    }
    
    public init(
        url: URL,
        proxyURL: URL?,
        height: UInt?,
        width: UInt?
    ) {
        self.url = url
        self.proxyURL = proxyURL
        self.height = height
        self.width = width
    }
    
}


public struct EmbedThumbnail: Codable {
    
    public let url: URL
    
    public let proxyURL: URL?
    
    public let height: UInt?
    
    public let width: UInt?
    
    enum CodingKeys: String, CodingKey {
        case url
        case proxyURL = "proxy_url"
        case height
        case width
    }
    
    public init(
        url: URL,
        proxyURL: URL?,
        height: UInt?, 
        width: UInt?
    ) {
        self.url = url
        self.proxyURL = proxyURL
        self.height = height
        self.width = width
    }
    
}


public struct EmbedVideo: Codable {
    
    public let url: URL
    
    public let proxyURL: URL?
    
    public let height: UInt?
    
    public let width: UInt?
    
    enum CodingKeys: String, CodingKey {
        case url
        case proxyURL = "proxy_url"
        case height
        case width
    }
    
    public init(
        url: URL,
        proxyURL: URL?,
        height: UInt?,
        width: UInt?
    ) {
        self.url = url
        self.proxyURL = proxyURL
        self.height = height
        self.width = width
    }
    
}


public struct EmbedProvider: Codable {
    
    let name: String?
    
    let url: URL?
    
    public init?(name: String?, url: URL?) {
        if name == nil && url == nil {
            return nil
        }
        self.name = name
        self.url = url
    }
    
    public init(name: String) {
        self.name = name
        self.url = nil
    }
    
    public init(url: URL) {
        self.name = nil
        self.url = url
    }
    
}


public struct EmbedAuthor: Codable {
    
    public let name: String
    
    public let url: URL?
    
    public let iconURL: URL?
    
    public let proxyIconURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case iconURL = "icon_url"
        case proxyIconURL = "proxy_icon_url"
    }
    
    public init(
        name: String,
        url: URL?,
        iconURL: URL?,
        proxyIconURL: URL?
    ) {
        self.name = name
        self.url = url
        self.iconURL = iconURL
        self.proxyIconURL = proxyIconURL
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
