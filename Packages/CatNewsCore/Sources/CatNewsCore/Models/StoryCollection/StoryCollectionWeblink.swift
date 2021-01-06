import Foundation

public struct StoryCollectionWeblink: Identifiable, Equatable, Decodable {

    public let id: String
    public let headline: String
    public let weblinkUrl: URL
    public let creationDate: Date
    public let modifiedDate: Date
    public let teaserImage: TeaserImage

    public init(id: String, headline: String, weblinkUrl: URL, creationDate: Date, modifiedDate: Date,
                teaserImage: TeaserImage) {
        self.id = id
        self.headline = headline
        self.weblinkUrl = weblinkUrl
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.teaserImage = teaserImage
    }

}
