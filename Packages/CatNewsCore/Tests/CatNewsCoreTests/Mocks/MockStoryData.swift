import CatNewsCore
import Foundation

let mockStory = Story(
    id: UUID().uuidString,
    headline: "Headline",
    heroImage: HeroImage(
        imageUrl: URL(string: "https://some.domain.com/image.jpg")!,
        accessibilityText: "Accessibility text"
    ),
    creationDate: Date(timeIntervalSinceNow: -64000),
    modifiedDate: Date(timeIntervalSinceNow: -64000),
    contents: [
        .paragraph(mockParagraph1),
        .image(mockImage1),
        .paragraph(mockParagraph2),
        .image(mockImage2)
    ]
)

let mockParagraph1 = StoryParagraph(text: "Some paragraph 1 text.")

let mockParagraph2 = StoryParagraph(text: "Some paragraph 2 text.")

let mockImage1 = StoryImage(
    url: URL(string: "https://some.domain.com/image1.jpg")!,
    accessibilityText: "Image 1 accessibility text"
)

let mockImage2 = StoryImage(
    url: URL(string: "https://some.domain.com/image2.jpg")!,
    accessibilityText: "Image 2 accessibility text"
)
