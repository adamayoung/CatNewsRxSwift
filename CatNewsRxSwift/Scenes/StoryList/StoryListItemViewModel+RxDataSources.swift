//
//  StoryListItemViewModel+RxDataSources.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Foundation
import RxDataSources

extension StoryListItemViewModel: IdentifiableType {

    var identity: String {
        id
    }

}
