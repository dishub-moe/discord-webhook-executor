import Foundation


fileprivate let DISCORD_BASE_URL = "https://discord.com/api"


public protocol Webhook {
    
    var url: URL { get }
    
    func execute(content: Content) async throws
    
}


public class URLSessionWebhook {
    
    private let session: URLSession
    
    private let encoder: JSONEncoder
    
    public let url: URL
    
    public init(id: String, token: String, using session: URLSession = URLSession.shared) {
        self.url = URL(string: "\(DISCORD_BASE_URL)/webhooks/\(id)/\(token)")!
        self.session = session
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
    }
    
    public init(url: URL, using session: URLSession = URLSession.shared) {
        self.url = url
        self.session = session
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
    }
    
}


extension URLSessionWebhook: Webhook {
    
    public func execute(content: Content) async throws {
        let (_, response) = try await session.data(for: usingMultipart(from: content))
        if !response.isSuccess {
            throw URLError(.badServerResponse)
        }
    }
    
    private func usingMultipart(from content: Content) throws -> URLRequest {
        let boundary = "boundary-BungaMungil-\(UUID().uuidString)"
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )
        urlRequest.httpBody = try multipartBody(from: content, using: boundary) as Data
        return urlRequest
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


extension URLResponse {
    
    var isSuccess: Bool {
        if let asHTTPURLResponse = self as? HTTPURLResponse {
            return asHTTPURLResponse.statusCode >= 200 && asHTTPURLResponse.statusCode <= 300
        }
        return false
    }
    
}
