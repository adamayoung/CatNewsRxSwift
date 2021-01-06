//
//  StoryListItemViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation

enum StoryListItemViewModel {

    case story(StoryListStoryViewModel)
    case weblink(StoryListWeblinkViewModel)
    case advert(StoryListAdvertViewModel)

    var id: String {
        switch self {
        case .story(let viewModel):
            return viewModel.id

        case .weblink(let viewModel):
            return viewModel.id

        case .advert(let viewModel):
            return viewModel.url.absoluteString
        }
    }

}

extension StoryListItemViewModel: Equatable {

    static func == (lhs: StoryListItemViewModel, rhs: StoryListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }

}
