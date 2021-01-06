import Foundation

public struct TeaserImage: Equatable {

    public let links: Links
    public let accessibilityText: String

    public init(links: Links, accessibilityText: String) {
        self.links = links
        self.accessibilityText = accessibilityText
    }

}

extension TeaserImage: Decodable {

    private enum CodingKeys: String, CodingKey {

        case links = "_links"
        case accessibilityText

    }

}

extension TeaserImage {

    public struct Links: Equatable, Decodable {

        public let url: LinkURL

        public init(url: LinkURL) {
            self.url = url
        }

    }

}

extension TeaserImage.Links {

    public struct LinkURL: Equatable, Decodable {

        public let href: URL
        public let templated: Bool
        public let type: String

        public init(href: URL, templated: Bool, type: String) {
            self.href = href
            self.templated = templated
            self.type = type
        }

    }

}
