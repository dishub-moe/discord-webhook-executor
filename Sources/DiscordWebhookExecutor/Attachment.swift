import Foundation


public struct Attachment {
    
    public let data: Data
    
    public let filename: String
    
    public let description: String
    
    public let contentType: String
    
    public init(
        data: Data,
        filename: String,
        description: String,
        contentType: String
    ) {
        self.data = data
        self.filename = filename
        self.description = description
        self.contentType = contentType
    }
    
}
