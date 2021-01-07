//
//  StoryListStoryViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryListStoryViewModelTests: XCTestCase {

    func testInitWithStory() throws {
        let story = StoryCollectionStory.mockData
        let viewModel = StoryListStoryViewModel(story: story)

        XCTAssertEqual(viewModel.id, story.id)
        XCTAssertEqual(viewModel.headline, story.headline)
        XCTAssertEqual(viewModel.teaserText, story.teaserText)
        XCTAssertEqual(viewModel.imageURL, story.teaserImage.links.url.href)
        XCTAssertEqual(viewModel.imageAccessibilityText, story.teaserImage.accessibilityText)
        XCTAssertEqual(viewModel.publishedDate, story.creationDate)
    }

}
