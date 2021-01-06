//
//  StoryCollectionItemViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import UIKit

protocol StoryListStoryViewModeling: class {

    var id: String { get }
    var headline: String { get }
    var teaserText: String { get }
    var imageURL: URL { get }
    var imageAccessibilityText: String { get }
    var publishedDate: Date { get }

}

final class StoryListStoryViewModel: StoryListStoryViewModeling {

    let id: String
    let headline: String
    let teaserText: String
    let imageURL: URL
    let imageAccessibilityText: String
    let publishedDate: Date

    init(id: String, headline: String, teaserText: String, imageURL: URL, imageAccessibilityText: String,
         publishedDate: Date) {
        self.id = id
        self.headline = headline
        self.teaserText = teaserText
        self.imageURL = imageURL
        self.imageAccessibilityText = imageAccessibilityText
        self.publishedDate = publishedDate
    }

}
