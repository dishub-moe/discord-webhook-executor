import Foundation


public struct Profile {
    
    let username: String?
    
    let avatarURL: URL?
    
    public init(username: String?, avatarURL: URL?) {
        self.username = username
        self.avatarURL = avatarURL
    }
    
}
