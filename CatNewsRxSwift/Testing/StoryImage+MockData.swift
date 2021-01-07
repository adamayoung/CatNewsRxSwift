//
//  StoryImage+MockData.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
import Foundation

extension StoryImage {

    static var mockData: StoryImage {
        StoryImage(
            url: URL(string: "https://some.domain.com/image1.jpg")!,
            accessibilityText: "Image 1 accessibility text"
        )
    }

    static var mockData2: StoryImage {
        StoryImage(
            url: URL(string: "https://some.domain.com/image2.jpg")!,
            accessibilityText: "Image 2 accessibility text"
        )
    }

}
