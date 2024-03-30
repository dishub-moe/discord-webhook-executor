import Foundation


public struct Content {
    
    let text: String?
    
    let embeds: [Embed]?
    
    let profile: Profile?
    
    let attachments: [Attachment]?
    
    internal init(
        text: String?,
        embeds: [Embed]?,
        profile: Profile?,
        attachments: [Attachment]?
    ) {
        self.text = text
        self.embeds = embeds
        self.profile = profile
        self.attachments = attachments
    }
    
    public static func builder(text: String) -> ContentBuilder {
        ContentBuilder(text: text)
    }
    
    public static func builder(embeds: [Embed]) -> ContentBuilder {
        ContentBuilder(embeds: embeds)
    }
    
    public static func builder(attachments: [Attachment]) -> ContentBuilder {
        ContentBuilder(attachments: attachments)
    }
    
}

public class ContentBuilder {
    
    private(set) var text: String? = nil
    
    private(set) var embeds: [Embed]? = nil
    
    private(set) var profile: Profile? = nil
    
    private(set) var attachments: [Attachment]? = nil
    
    internal init(text: String) {
        self.text = text
    }
    
    internal init(embeds: [Embed]) {
        self.embeds = embeds
    }
    
    internal init(attachments: [Attachment]) {
        self.attachments = attachments
    }
    
    public func text(_ text: String) -> ContentBuilder {
        self.text = text
        return self
    }
    
    public func embeds(_ embeds: [Embed]) -> ContentBuilder {
        self.embeds = embeds
        return self
    }
    
    public func profile(_ profile: Profile) -> ContentBuilder {
        self.profile = profile
        return self
    }
    
    public func attachments(_ attachments: [Attachment]) -> ContentBuilder {
        self.attachments = attachments
        return self
    }
    
    public func build() -> Content {
        return Content(
            text: text,
            embeds: embeds,
            profile: profile,
            attachments: attachments
        )
    }
    
}
