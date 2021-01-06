//
//  StorySubheaderViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation

protocol StorySubheaderViewModeling {

    var publishedDate: Date { get }

}

final class StorySubheaderViewModel: StorySubheaderViewModeling {

    let publishedDate: Date

    init(publishedDate: Date) {
        self.publishedDate = publishedDate
    }

}
