//
//  StoryCollectionItemViewModel+StoryCollectionStory.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryListStoryViewModel {

    convenience init(story: StoryCollectionStory) {
        self.init(id: story.id, headline: story.headline, teaserText: story.teaserText,
                  imageURL: story.teaserImage.links.url.href,
                  imageAccessibilityText: story.teaserImage.accessibilityText, publishedDate: story.creationDate)
    }

}
