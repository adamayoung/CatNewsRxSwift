//
//  StoryListItemViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryListItemViewModelTests: XCTestCase {

    func testInitWithStoryItem() {
        let story = StoryCollectionStory.mockData
        let item = StoryCollectionItem.story(story)
        let expectedResultID = story.id

        let viewModel = StoryListItemViewModel(item: item)

        switch viewModel {
        case .story(let result):
            XCTAssertEqual(result.id, expectedResultID)

        default:
            XCTFail("Should have created a story StoryListItemViewModel")
        }
    }

    func testInitWithWeblinkItem() {
        let weblink = StoryCollectionWeblink.mockData
        let item = StoryCollectionItem.weblink(weblink)
        let expectedResultID = weblink.id

        let viewModel = StoryListItemViewModel(item: item)

        switch viewModel {
        case .weblink(let result):
            XCTAssertEqual(result.id, expectedResultID)

        default:
            XCTFail("Should have created a weblink StoryListItemViewModel")
        }
    }

    func testInitWithAdvertItem() {
        let advert = StoryCollectionAdvert.mockData
        let item = StoryCollectionItem.advert(advert)
        let expectedResultURL = advert.url

        let viewModel = StoryListItemViewModel(item: item)

        switch viewModel {
        case .advert(let result):
            XCTAssertEqual(result.url, expectedResultURL)

        default:
            XCTFail("Should have created an advert StoryListItemViewModel")
        }
    }

}
