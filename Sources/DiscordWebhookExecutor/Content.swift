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


extension Content {
    
    private static let encoder: JSONEncoder = ISO8601JSONEncoder()
    
    public func multipartBody(using boundary: String) throws -> Data {
        let boundaryPrefix = "--\(boundary)\r\n".utf8.data
        let boundarySuffix = "--\(boundary)--".utf8.data
        let httpBody = NSMutableData()
        httpBody.append(boundaryPrefix)
        httpBody.append("Content-Disposition: form-data; name=\"payload_json\"\r\n".utf8.data)
        httpBody.append("Content-Type: application/json\r\n\r\n".utf8.data)
        httpBody.append(try Content.encoder.encode(Payload(content: self)))
        if let attachments = self.attachments {
            var counter = 0
            for attachment in attachments {
                httpBody.append("\r\n".utf8.data)
                httpBody.append(boundaryPrefix)
                httpBody.append("Content-Disposition: form-data; name=\"files[\(counter)]\"; filename=\"\(attachment.filename)\"\r\n".utf8.data)
                httpBody.append("Content-Type: \(attachment.contentType)\r\n\r\n".utf8.data)
                httpBody.append(attachment.data)
                counter += 1
            }
        }
        httpBody.append("\r\n".utf8.data)
        httpBody.append(boundarySuffix)
        return httpBody as Data
    }
    
}


extension String.UTF8View {
    
    fileprivate var data: Data { Data(self) }
    
}


private class ISO8601JSONEncoder: JSONEncoder {
    
    override init() {
        super.init()
        dateEncodingStrategy = .iso8601
    }
    
}
