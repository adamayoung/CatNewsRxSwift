//
//  StoryCollection+MockData.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryCollection {

    static var mockData: StoryCollection {
        StoryCollection(
            title: "Mock Cat News",
            data: [
                .story(.mockData),
                .weblink(.mockData),
                .story(.mockData2),
                .advert(.mockData)
            ]
        )
    }

}

extension StoryCollectionStory {

    static var mockData: StoryCollectionStory {
        StoryCollectionStory(
            id: "1",
            headline: "Headline 1",
            teaserText: "Teaster 1",
            creationDate: Date(timeIntervalSince1970: 1607432233),
            modifiedDate: Date(timeIntervalSince1970: 1607432233),
            teaserImage: TeaserImage(
                links: TeaserImage.Links(
                    url: TeaserImage.Links.LinkURL(
                        href: URL(string: "https://some.domain.com/image1a.jpg")!,
                        templated: true,
                        type: "image/jpg"
                    )
                ),
                accessibilityText: "Accessibility text 1a"
            )
        )
    }

    static var mockData2: StoryCollectionStory {
        StoryCollectionStory(
            id: "3",
            headline: "Headline 3",
            teaserText: "Teaster 3",
            creationDate: Date(timeIntervalSince1970: 1607452233),
            modifiedDate: Date(timeIntervalSince1970: 1607452233),
            teaserImage: TeaserImage(
                links: TeaserImage.Links(
                    url: TeaserImage.Links.LinkURL(
                        href: URL(string: "https://some.domain.com/image3a.jpg")!,
                        templated: true,
                        type: "image/jpg"
                    )
                ),
                accessibilityText: "Accessibility text 3a"
            )
        )
    }

}

extension StoryCollectionWeblink {

    static var mockData: StoryCollectionWeblink {
        StoryCollectionWeblink(
            id: "2",
            headline: "Weblink 2",
            weblinkUrl: URL(string: "https://www.sky.com")!,
            creationDate: Date(timeIntervalSince1970: 1607442233),
            modifiedDate: Date(timeIntervalSince1970: 1607442233),
            teaserImage: TeaserImage(
                links: TeaserImage.Links(
                    url: TeaserImage.Links.LinkURL(
                        href: URL(string: "https://some.domain.com/image2a.jpg")!,
                        templated: true,
                        type: "image/jpg"
                    )
                ),
                accessibilityText: "Accessibility text 2a"
            )
        )
    }

}

extension StoryCollectionAdvert {

    static var mockData: StoryCollectionAdvert {
        StoryCollectionAdvert(
            url: URL(string: "https://some.domain.com/advert.jpg")!
        )
    }

}
