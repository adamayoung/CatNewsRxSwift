import Foundation

public struct StoryCollectionAdvert: Equatable, Decodable {

    public let url: URL

    public init(url: URL) {
        self.url = url
    }

}
