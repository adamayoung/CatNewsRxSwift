//
//  StoriesSection.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation
import RxDataSources

struct StoriesSection {

    var header: String
    var items: [Item]
}

extension StoriesSection: AnimatableSectionModelType {

    typealias Item = StoryListItemViewModel

    var identity: String {
        return header
    }

    init(original: StoriesSection, items: [Item]) {
        self = original
        self.items = items
    }

}
