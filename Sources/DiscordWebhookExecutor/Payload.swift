import Foundation


public struct Payload: Encodable {
    
    let content: String?
    
    let username: String?
    
    let avatarURL: URL?
    
    let embeds: [Embed]?
    
    let attachments: [AttachmentPayload]?
    
    enum CodingKeys: String, CodingKey {
        case content
        case username
        case avatarURL = "avatar_url"
        case embeds
        case attachments
    }
    
    public init(content: Content) {
        self.content = content.text
        self.username = content.profile?.username
        self.avatarURL = content.profile?.avatarURL
        self.embeds = content.embeds
        if let attachments = content.attachments {
            var counter: UInt = 0
            var attachmentPayloads: [AttachmentPayload] = []
            for attachment in attachments {
                attachmentPayloads.append(
                    AttachmentPayload(
                        id: counter,
                        filename: attachment.filename,
                        description: attachment.description
                    )
                )
                counter += 1
            }
            self.attachments = attachmentPayloads
        } else {
            self.attachments = nil
        }
    }
    
}


public struct AttachmentPayload: Encodable {
    
    let id: UInt
    
    let filename: String
    
    let description: String?
    
}
