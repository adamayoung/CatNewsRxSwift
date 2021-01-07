//
//  StoryViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryViewModelTests: XCTestCase {

    func testInitWithStory() {
        let story = Story.mockData
        let viewModel = StoryViewModel(story: story)

        XCTAssertEqual(viewModel.id, story.id)
        XCTAssertEqual(viewModel.headline, story.headline)
        XCTAssertEqual(viewModel.heroImageURL, story.heroImage.imageUrl)
        XCTAssertEqual(viewModel.heroImageAccessibilityText, story.heroImage.accessibilityText)
        XCTAssertEqual(viewModel.creationDate, story.creationDate)
        XCTAssertEqual(viewModel.modifiedDate, story.modifiedDate)
        XCTAssertEqual(viewModel.contents.count, story.contents.count)
    }

}
