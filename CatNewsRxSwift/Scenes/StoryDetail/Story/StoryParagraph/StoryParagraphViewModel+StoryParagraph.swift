//
//  StoryParagraphViewModel+StoryParagraph.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryParagraphViewModel {

    convenience init(paragraph: StoryParagraph) {
        self.init(text: paragraph.text)
    }

}
