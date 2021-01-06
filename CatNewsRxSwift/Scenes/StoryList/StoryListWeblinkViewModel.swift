//
//  StoryListWeblinkViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation

protocol StoryListWeblinkViewModeling: class {

    var id: String { get }
    var headline: String { get }
    var url: URL { get }
    var imageURL: URL { get }
    var imageAccessibilityText: String { get }
    var publishedDate: Date { get }

}

final class StoryListWeblinkViewModel: StoryListWeblinkViewModeling {

    let id: String
    let headline: String
    let url: URL
    let imageURL: URL
    let imageAccessibilityText: String
    let publishedDate: Date

    init(id: String, headline: String, url: URL, imageURL: URL, imageAccessibilityText: String, publishedDate: Date) {
        self.id = id
        self.headline = headline
        self.url = url
        self.imageURL = imageURL
        self.imageAccessibilityText = imageAccessibilityText
        self.publishedDate = publishedDate
    }

}
