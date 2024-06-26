import AsyncHTTPClient
import XCTest
import DiscordWebhookExecutor


final class DiscordWebhookExecutorTests: XCTestCase {
    
    let webhook: Webhook = HTTPClientDiscordWebhook(
        URL(string: ProcessInfo.processInfo.environment["DISCORD_WEBHOOK_URL"]!)!,
        using: HTTPClient(eventLoopGroupProvider: .singleton)
    )
    
    func testBasic() async throws {
        try await webhook.execute(
            content: Content
                .builder(text: "This is a test message sent from XCTest")
                .build()
        )
    }
    
    func testWithProfile() async throws {
        try await webhook.execute(
            content: Content
                .builder(text: "This is a test message sent from XCTest")
                .profile(
                    Profile(
                        username: "User Testing 1",
                        avatarURL: URL(string: "https://i.pravatar.cc/150?u=discord-webhook-executor")
                    )
                )
                .build()
        )
    }
    
    func testWithEmbeds() async throws {
        try await webhook.execute(
            content: Content
                .builder(
                    embeds: [
                        Embed(
                            title: "This is an embed's title",
                            description: "This is an embed's description",
                            url: URL(string: "https://github.com/dishub-moe/discord-webhook-executor.git"),
                            timestamp: Date(),
                            color: 0x00ff00,
                            footer: EmbedFooter(
                                text: "This is an embed's footer",
                                iconURL: URL(string: "https://i.pravatar.cc/150?u=discord-webhook-executor")
                            ),
                            image: EmbedImage(
                                url: URL(string: "https://i.pravatar.cc/150?u=discord-webhook-executor")!
                            ),
                            thumbnail: EmbedThumbnail(
                                url: URL(string: "https://cataas.com/cat")!
                            ),
                            author: EmbedAuthor(
                                name: "This is an embed's author",
                                url: URL(string: "https://github.com/dishub-moe/discord-webhook-executor.git"),
                                iconURL: URL(string: "https://i.pravatar.cc/150?u=discord-webhook-executor")
                            ),
                            fields: [
                                EmbedField(
                                    name: "This is an embed's field",
                                    value: "Value of field 1",
                                    inline: true
                                ),
                                EmbedField(
                                    name: "This is an embed's field",
                                    value: "Value of field 2",
                                    inline: true
                                ),
                                EmbedField(
                                    name: "This is an embed's field",
                                    value: "Value of field 3",
                                    inline: false
                                ),
                                EmbedField(
                                    name: "This is an embed's field",
                                    value: "Value of field 4",
                                    inline: true
                                ),
                                EmbedField(
                                    name: "This is an embed's field",
                                    value: "Value of field 5",
                                    inline: true
                                )
                            ]
                        )
                    ]
                )
                .text("Add text here")
                .profile(
                    Profile(
                        username: "User Testing 2",
                        avatarURL: URL(string: "https://i.pravatar.cc/150?u=discord-webhook-executor")
                    )
                )
                .build()
        )
    }
    
    func testWithAttachments() async throws {
        let path = Bundle.module.path(forResource: "Sample PDF Document", ofType: "pdf")!
        let file = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: file)
        try await webhook.execute(
            content: Content
                .builder(text: "This is a test message sent from XCTest")
                .attachments(
                    [
                        Attachment(
                            data: data,
                            filename: "Sample PDF Document.pdf",
                            description: "Sample Description File",
                            contentType: "application/pdf"
                        )
                    ]
                )
                .profile(
                    Profile(
                        username: "User Testing 3",
                        avatarURL: URL(string: "https://i.pravatar.cc/150?u=discord-webhook-executor")
                    )
                )
                .build()
        )
    }
    
    func testOnlyAttachment() async throws {
        let path = Bundle.module.path(forResource: "Sample PDF Document", ofType: "pdf")!
        let file = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: file)
        try await webhook.execute(
            content: Content
                .builder(attachments: [
                    Attachment(
                        data: data,
                        filename: "Sample PDF Document.pdf",
                        description: "Sample Description File",
                        contentType: "application/pdf"
                    )
                ])
                .build()
        )
    }
    
}
