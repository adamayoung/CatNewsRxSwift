//
//  StoryImageViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation

protocol StoryImageViewModeling {

    var url: URL { get }
    var accessibilityText: String { get }

}

final class StoryImageViewModel: StoryImageViewModeling {

    let url: URL
    let accessibilityText: String

    init(url: URL, accessibilityText: String) {
        self.url = url
        self.accessibilityText = accessibilityText
    }

}
