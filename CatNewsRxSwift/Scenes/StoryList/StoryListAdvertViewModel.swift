//
//  StoryListAdvertViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation

protocol StoryListAdvertViewModeling: class {

    var url: URL { get }

}

final class StoryListAdvertViewModel: StoryListAdvertViewModeling {

    let url: URL

    init(url: URL) {
        self.url = url
    }

}
