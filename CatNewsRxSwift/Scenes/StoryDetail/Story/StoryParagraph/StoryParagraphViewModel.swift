//
//  StoryParagraphViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation

protocol StoryParagraphViewModeling {

    var text: String { get }
}

final class StoryParagraphViewModel: StoryParagraphViewModeling {

    let text: String

    init(text: String) {
        self.text = text
    }

}
