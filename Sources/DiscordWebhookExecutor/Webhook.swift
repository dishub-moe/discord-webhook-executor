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
    
    private let encoder: JSONEncoder
    
    public init(_ url: URL, using client: HTTPClient) {
        self.client = client
        self.url = url
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
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
                try multipartBody(
                    from: content,
                    using: boundary
                )
            )
        )
        let response = try await client.execute(request: request).get()
        if !response.status.isSuccess {
            throw HTTPError(from: response)
        }
    }
    
    private func multipartBody(from content: Content, using boundary: String) throws -> Data {
        let boundaryPrefix = "--\(boundary)\r\n".utf8.data
        let boundarySuffix = "--\(boundary)--".utf8.data
        let httpBody = NSMutableData()
        httpBody.append(boundaryPrefix)
        httpBody.append("Content-Disposition: form-data; name=\"payload_json\"\r\n".utf8.data)
        httpBody.append("Content-Type: application/json\r\n\r\n".utf8.data)
        httpBody.append(try encoder.encode(Payload(content: content)))
        if let attachments = content.attachments {
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
