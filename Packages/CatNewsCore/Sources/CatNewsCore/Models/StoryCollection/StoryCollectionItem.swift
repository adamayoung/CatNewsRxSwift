import Foundation

public enum StoryCollectionItem: Equatable {

    case story(StoryCollectionStory)
    case weblink(StoryCollectionWeblink)
    case advert(StoryCollectionAdvert)

}

extension StoryCollectionItem: Decodable {

    public struct InvalidStoryCollectionItemTypeError: Error {

        public let type: String

    }

    private enum CodingKeys: CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "story":
            self = .story(try StoryCollectionStory(from: decoder))

        case "weblink":
            self = .weblink(try StoryCollectionWeblink(from: decoder))

        case "advert":
            self = .advert(try StoryCollectionAdvert(from: decoder))

        default:
            throw InvalidStoryCollectionItemTypeError(type: type)
        }
    }

}
