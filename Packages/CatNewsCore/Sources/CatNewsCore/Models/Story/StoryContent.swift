import Foundation

public enum StoryContent: Equatable {

    case paragraph(StoryParagraph)
    case image(StoryImage)

}

extension StoryContent: Decodable {

    public struct InvalidStoryContentTypeError: Error {

        public let type: String

    }

    private enum CodingKeys: CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "paragraph":
            self = .paragraph(try StoryParagraph(from: decoder))

        case "image":
            self = .image(try StoryImage(from: decoder))

        default:
            throw InvalidStoryContentTypeError(type: type)
        }
    }

}
