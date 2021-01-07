//
//  StoryListWeblinkViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryListWeblinkViewModelTests: XCTestCase {

    func testInitWithWeblink() throws {
        let weblink = StoryCollectionWeblink.mockData
        let viewModel = StoryListWeblinkViewModel(weblink: weblink)

        XCTAssertEqual(viewModel.id, weblink.id)
        XCTAssertEqual(viewModel.headline, weblink.headline)
        XCTAssertEqual(viewModel.url, weblink.weblinkUrl)
        XCTAssertEqual(viewModel.imageURL, weblink.teaserImage.links.url.href)
        XCTAssertEqual(viewModel.imageAccessibilityText, weblink.teaserImage.accessibilityText)
        XCTAssertEqual(viewModel.publishedDate, weblink.creationDate)
    }

}
