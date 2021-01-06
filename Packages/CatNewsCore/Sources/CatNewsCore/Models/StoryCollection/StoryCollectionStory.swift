import Foundation

public struct StoryCollectionStory: Identifiable, Equatable, Decodable {

    public let id: String
    public let headline: String
    public let teaserText: String
    public let creationDate: Date
    public let modifiedDate: Date
    public let teaserImage: TeaserImage

    public init(id: String, headline: String, teaserText: String, creationDate: Date, modifiedDate: Date,
                teaserImage: TeaserImage) {
        self.id = id
        self.headline = headline
        self.teaserText = teaserText
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.teaserImage = teaserImage
    }

}
