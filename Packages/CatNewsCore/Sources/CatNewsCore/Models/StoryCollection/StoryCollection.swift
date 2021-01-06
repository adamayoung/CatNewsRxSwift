import Foundation

public struct StoryCollection: Equatable, Decodable {

    public let title: String
    public let data: [StoryCollectionItem]

    public init(title: String, data: [StoryCollectionItem]) {
        self.title = title
        self.data = data
    }

}
