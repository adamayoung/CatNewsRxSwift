//
//  StoryParagraphViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryParagraphViewModelTests: XCTestCase {

    func testInitWithParagraph() {
        let paragraph = StoryParagraph.mockData

        let viewModel = StoryParagraphViewModel(paragraph: paragraph)

        XCTAssertEqual(viewModel.text, paragraph.text)
    }

}
