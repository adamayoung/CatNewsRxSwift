//
//  StoryListWeblinkViewModel+StoryCollectionWeblink.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021..
//

import CatNewsCore
import Foundation

extension StoryListWeblinkViewModel {

    convenience init(weblink: StoryCollectionWeblink) {
        self.init(id: weblink.id, headline: weblink.headline, url: weblink.weblinkUrl,
                  imageURL: weblink.teaserImage.links.url.href,
                  imageAccessibilityText: weblink.teaserImage.accessibilityText, publishedDate: weblink.creationDate)
    }

}
