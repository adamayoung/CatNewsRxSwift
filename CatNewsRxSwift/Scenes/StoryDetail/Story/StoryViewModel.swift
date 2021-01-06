//
//  StoryViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation

protocol StoryViewModeling {

    var id: String { get }
    var headline: String { get }
    var heroImageURL: URL { get }
    var heroImageAccessibilityText: String { get }
    var creationDate: Date { get }
    var modifiedDate: Date { get }
    var contents: [StoryContentItem] { get }

}

final class StoryViewModel: StoryViewModeling {

    let id: String
    let headline: String
    let heroImageURL: URL
    let heroImageAccessibilityText: String
    let creationDate: Date
    let modifiedDate: Date
    let contents: [StoryContentItem]

    init(id: String, headline: String, heroImageURL: URL, heroImageAccessibilityText: String, creationDate: Date,
         modifiedDate: Date, contents: [StoryContentItem]) {
        self.id = id
        self.headline = headline
        self.heroImageURL = heroImageURL
        self.heroImageAccessibilityText = heroImageAccessibilityText
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.contents = contents
    }

}
