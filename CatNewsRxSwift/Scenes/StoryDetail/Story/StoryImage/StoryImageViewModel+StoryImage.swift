//
//  StoryImageViewModel+StoryImage.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation

extension StoryImageViewModel {

    convenience init(image: StoryImage) {
        self.init(url: image.url, accessibilityText: image.accessibilityText)
    }

}
