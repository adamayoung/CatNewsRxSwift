//
//  StoryDetailViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation
import os.log

protocol StoryDetailViewModeling {

    var storyID: String { get }

}

final class StoryDetailViewModel: StoryDetailViewModeling {

    let storyID: String

    private let newsStore: NewsStore

    init(storyID: String, newsStore: NewsStore) {
        self.storyID = storyID
        self.newsStore = newsStore
    }

}

extension StoryDetailViewModel {

    struct StoryNotFoundError: Error { }

}
