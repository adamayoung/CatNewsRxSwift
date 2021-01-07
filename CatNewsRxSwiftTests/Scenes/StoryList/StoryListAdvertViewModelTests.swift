//
//  StoryListAdvertViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryListAdvertViewModelTests: XCTestCase {

    func testInitWithAdvert() throws {
        let advert = StoryCollectionAdvert.mockData
        let viewModel = StoryListAdvertViewModel(advert: advert)

        XCTAssertEqual(viewModel.url, advert.url)
    }

}
