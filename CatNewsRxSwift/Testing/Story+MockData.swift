//
//  Story+MockData.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension Story {

    static var mockData: Story {
        Story(
            id: "1",
            headline: "Headline 1",
            heroImage: HeroImage(
                imageUrl: URL(string: "https://some.domain.com/image.jpg")!,
                accessibilityText: "Accessibility text"
            ),
            creationDate: Date(timeIntervalSinceNow: -64000),
            modifiedDate: Date(timeIntervalSinceNow: -64000),
            contents: [
                .paragraph(StoryParagraph(text: "Some paragraph 1 text.")),
                .image(StoryImage(
                    url: URL(string: "https://some.domain.com/image1.jpg")!,
                    accessibilityText: "Image 1 accessibility text"
                )),
                .paragraph(StoryParagraph(text: "Some paragraph 2 text.")),
                .image(StoryImage(
                    url: URL(string: "https://some.domain.com/image2.jpg")!,
                    accessibilityText: "Image 2 accessibility text"
                ))
            ]
        )
    }

    static var mockData2: Story {
        Story(
            id: "3",
            headline: "Headline 3",
            heroImage: HeroImage(
                imageUrl: URL(string: "https://some.domain.com/image.jpg")!,
                accessibilityText: "Accessibility text"
            ),
            creationDate: Date(timeIntervalSinceNow: -64000),
            modifiedDate: Date(timeIntervalSinceNow: -64000),
            contents: [
                .paragraph(StoryParagraph(text: "Some paragraph 1 text.")),
                .image(StoryImage(
                    url: URL(string: "https://some.domain.com/image1.jpg")!,
                    accessibilityText: "Image 1 accessibility text"
                )),
                .paragraph(StoryParagraph(text: "Some paragraph 2 text.")),
                .image(StoryImage(
                    url: URL(string: "https://some.domain.com/image2.jpg")!,
                    accessibilityText: "Image 2 accessibility text"
                ))
            ]
        )
    }

}
