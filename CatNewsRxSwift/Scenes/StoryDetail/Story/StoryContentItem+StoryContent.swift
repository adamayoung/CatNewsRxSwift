//
//  StoryContentItem+StoryContent.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryContentItem {

    init(content: StoryContent) {
        switch content {
        case .paragraph(let paragraph):
            self = .paragraph(StoryParagraphViewModel(paragraph: paragraph))

        case .image(let image):
            self = .image(StoryImageViewModel(image: image))

        }
    }

}
