import AsyncHTTPClient
import Foundation
import NIOHTTP1


fileprivate let DISCORD_BASE_URL = "https://discord.com/api"


public protocol Webhook {
    
    var url: URL { get }
    
    func execute(content: Content) async throws
    
}


public class HTTPClientDiscordWebhook {
    
    public let url: URL
    
    private let client: HTTPClient
    
    public init(_ url: URL, using client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
}


extension HTTPClientDiscordWebhook: Webhook {
    
    public func execute(content: Content) async throws {
        let boundary = "boundary-BungaMungil-\(UUID().uuidString)"
        let request = try HTTPClient.Request(
            url: url.absoluteString,
            method: .POST,
            headers: [
                "Content-Type": "multipart/form-data; boundary=\(boundary)"
            ],
            body: .bytes(
                try content.multipartBody(using: boundary)
            )
        )
        let response = try await client.execute(request: request).get()
        if !response.status.isSuccess {
            throw HTTPError(from: response)
        }
    }
    
}


extension HTTPResponseStatus {
    
    var isSuccess: Bool {
        return code >= 200 && code <= 300
    }
    
}


public struct HTTPError: LocalizedError {
    
    let response: HTTPClient.Response
    
    public var errorDescription: String? { response.status.reasonPhrase }
    
    init(from response: HTTPClient.Response) {
        self.response = response
    }
    
}
