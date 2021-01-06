import Foundation

public struct StoryParagraph: Equatable, Decodable {

    public let text: String

    public init(text: String) {
        self.text = text
    }

}
