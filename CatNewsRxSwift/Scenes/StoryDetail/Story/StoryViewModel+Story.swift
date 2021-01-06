//
//  StoryViewModel+Story.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryViewModel {

    convenience init(story: Story) {
        let contents = story.contents.map(StoryContentItem.init)

        self.init(id: story.id, headline: story.headline, heroImageURL: story.heroImage.imageUrl,
                  heroImageAccessibilityText: story.heroImage.accessibilityText, creationDate: story.creationDate,
                  modifiedDate: story.modifiedDate, contents: contents)
    }

}
