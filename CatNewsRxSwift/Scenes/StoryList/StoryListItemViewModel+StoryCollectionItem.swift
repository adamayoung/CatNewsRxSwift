//
//  StoryListItemViewModel+StoryCollectionItem.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryListItemViewModel {

    init(item: StoryCollectionItem) {
        switch item {
        case .story(let story):
            self = .story(StoryListStoryViewModel(story: story))

        case .weblink(let weblink):
            self = .weblink(StoryListWeblinkViewModel(weblink: weblink))

        case .advert(let advert):
            self = .advert(StoryListAdvertViewModel(advert: advert))
        }
    }

}
