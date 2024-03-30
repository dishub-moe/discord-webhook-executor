# DiscordWebhookExecutor

DiscordWebhookExecutor is, as the name implies, a package that provide convenience way to execute Discord Webhook, written in Swift.

## Setup

DiscordWebhookExecutor is available on Swift Package Manager. Add this package to your Package.swift :

```swift
let package = Package(
    // other package's declaration fields
    dependencies: [
        // other package's dependencies
        // branch: "main" option can be changed to a specific version
        .package(url: "https://github.com/dishub-moe/discord-webhook-executor.git", branch: "main")
    ],
    targets: [
        .executableTarget( // the target that will be using DiscordWebhookExecutor
            // other target's declaration fields
            dependencies: [
                // other target's dependencies
                .product(name: "DiscordWebhookExecutor", package: "discord-webhook-executor")
            ]
        ),
    ]
)

```

As an alternative, you can download the source code and directly add them to your project.

## Usage

First, you need to create a `Webhook` instance. By default, this package contains `URLSessionWebhook` class that can be used to create a `Webhook` instance.

```swift
let webhook = URLSessionWebhook(url: URL(string: "https://discord.com/api/webhooks/.../...")!)
```

### Composing Content

Composing content (message) that will be send using Discord webhook, use the `Content` class. It uses the builder pattern to create an instance.

#### Basic

To compose a basic message (only contains text), call the `.builder(text:)` static method on the `Content` instance.

```swift
let content = Content
    .builder(text: "This is a test message composed from the README documentation")
```

#### Profile

To override the Discord webhook's username and avatar, call the `.profile(_)` and pass a `Profile` instance after `.builder(*)` call.

```swift
let content = Content
    .builder(text: "This is a test message composed from the README documentation")
    .profile(
        Profile(
            username: "Overriden username",
            avatarURL: URL(string: "https://i.pravatar.cc/150?u=discord-webhook-executor")
        )
    )
```

#### Embeds

To start composing a message with embeds, call the `.builder(embeds:)` static method on the `Content` instance.

```swift
let content = Content
    .builder(embeds: [/** Put `Embed`s instance here **/])
```

Or to add embeds later, call the `.embeds(_)` method on the `ContentBuilder` instance.

```swift
let content = Content
    .builder(text: "This is a test message composed from the README documentation")
    .embeds([/** Put `Embed`s instance here **/])
```

The `Embed` type is a struct and it's already starightforward. You can read more about the embed's fields from the [official Discord documentation](https://discord.com/developers/docs/resources/channel#embed-object-embed-structure).

#### Attachments

To start composing a message with attachments, call the `.builder(attachments:)` static method on the `Content` instance.

```swift
let content = Content
    .builder(attachments: [/** Put `Attachment`s instance here **/])
```

Or to add attachments later, call the `.attachments(_)` method on the `ContentBuilder` instance.

```swift
let content = Content
    .builder(text: "This is a test message composed from the README documentation")
    .attachments([/** Put `Attachment`s instance here **/])
```

The `Attachment` type is a struct and it's already starightforward. You can read more about the attachment's fields from the [official Discord documentation](https://discord.com/developers/docs/resources/channel#attachment-object-attachment-structure).

### Sending Content

To send the content, call `.build()` to the `ContentBuilder` instance and pass it to `.execute(content:)` of the `Webhook` instance.

```swift
let content = Content
    .builder(text: "This is a test message composed from the README documentation")
    .build()
try await webhook.execute(content: content)
```

## Limitations

Quoting [Discord's Developer Documentation](https://discord.com/developers/docs/resources/channel#create-message-limitations), there are limitations on executing webhook.

> - When operating on a guild channel, the current user must have the SEND_MESSAGES permission.
> - When sending a message with tts (text-to-speech) set to true, the current user must have the SEND_TTS_MESSAGES permission.
> - When creating a message as a reply to another message, the current user must have the READ_MESSAGE_HISTORY permission.
> - The referenced message must exist and cannot be a system message.
> - The maximum request size when sending a message is 25 MiB
> - For the embed object, you can set every field except type (it will be rich regardless of if you try to set it), provider, video, and any height, width, or proxy_url values for images.

## Contributing

We welcome any contributions. Feel free to submit your changes via pull request or report issues on issue tracker. We will check them periodically.

## Copyright Notice

Discord is a trademark of Discord Inc. The mentions of "Discord" is only related to the functionalities of this package and not the endorsement. We are not affiliated with Discord Inc.
