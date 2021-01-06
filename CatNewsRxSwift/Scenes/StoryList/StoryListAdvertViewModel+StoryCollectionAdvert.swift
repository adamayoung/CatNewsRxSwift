//
//  StoryListAdvertViewModel+StoryCollectionAdvert.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryListAdvertViewModel {

    convenience init(advert: StoryCollectionAdvert) {
        self.init(url: advert.url)
    }

}
