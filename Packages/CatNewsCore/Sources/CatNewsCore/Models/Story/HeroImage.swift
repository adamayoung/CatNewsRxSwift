import Foundation

public struct HeroImage: Equatable, Decodable {

    public let imageUrl: URL
    public let accessibilityText: String

    public init(imageUrl: URL, accessibilityText: String) {
        self.imageUrl = imageUrl
        self.accessibilityText = accessibilityText
    }

}
