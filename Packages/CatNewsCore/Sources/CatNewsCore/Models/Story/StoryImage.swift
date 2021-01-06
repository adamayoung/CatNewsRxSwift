import Foundation

public struct StoryImage: Equatable, Decodable {

    public let url: URL
    public let accessibilityText: String

    public init(url: URL, accessibilityText: String) {
        self.url = url
        self.accessibilityText = accessibilityText
    }

}
