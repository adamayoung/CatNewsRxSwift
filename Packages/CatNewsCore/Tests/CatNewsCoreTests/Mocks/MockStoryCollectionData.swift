import CatNewsCore
import Foundation

let mockStoryCollection = StoryCollection(
    title: "Some title",
    data: [
        .story(mockStoryCollectionStory1),
        .weblink(mockStoryCollectionWeblink1),
        .advert(mockStoryCollectionAdvert1)
    ]
)

let mockStoryCollectionStory1 = StoryCollectionStory(
    id: UUID().uuidString,
    headline: "Headline 1",
    teaserText: "Teaster 1",
    creationDate: Date(timeIntervalSinceNow: -16000),
    modifiedDate: Date(timeIntervalSinceNow: -16000),
    teaserImage: TeaserImage(
        links: TeaserImage.Links(
            url: TeaserImage.Links.LinkURL(
                href: URL(string: "https://some.domain.com/image1.jpg")!,
                templated: true,
                type: "image/jpg"
            )
        ),
        accessibilityText: "Accessibility text 1"
    )
)

let mockStoryCollectionWeblink1 = StoryCollectionWeblink(
    id: UUID().uuidString,
    headline: "Headline 2",
    weblinkUrl: URL(string: "https://some.domain.com/some-weblink")!,
    creationDate: Date(timeIntervalSinceNow: -32000),
    modifiedDate: Date(timeIntervalSinceNow: -32000),
    teaserImage: TeaserImage(
        links: TeaserImage.Links(
            url: TeaserImage.Links.LinkURL(
                href: URL(string: "https://some.domain.com/image2.jpg")!,
                templated: true,
                type: "image/jpg"
            )
        ),
        accessibilityText: "Accessibility text 2"
    )
)

let mockStoryCollectionAdvert1 = StoryCollectionAdvert(
    url: URL(string: "https://some.domain.com/advert.jpg")!
)
