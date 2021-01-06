import Foundation

public struct Story: Identifiable, Equatable, Decodable {

    public let id: String
    public let headline: String
    public let heroImage: HeroImage
    public let creationDate: Date
    public let modifiedDate: Date
    public let contents: [StoryContent]

    public init(id: String, headline: String, heroImage: HeroImage, creationDate: Date, modifiedDate: Date,
                contents: [StoryContent]) {
        self.id = id
        self.headline = headline
        self.heroImage = heroImage
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.contents = contents
    }

}
