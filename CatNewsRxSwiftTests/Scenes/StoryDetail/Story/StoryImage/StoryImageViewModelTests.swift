//
//  StoryImageViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryImageViewModelTests: XCTestCase {

    func testInitWithImage() {
        let image = StoryImage.mockData

        let viewModel = StoryImageViewModel(image: image)

        XCTAssertEqual(viewModel.url, image.url)
        XCTAssertEqual(viewModel.accessibilityText, image.accessibilityText)
    }

}
