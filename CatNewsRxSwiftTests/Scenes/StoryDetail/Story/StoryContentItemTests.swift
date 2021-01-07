//
//  StoryContentItemTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import XCTest

class StoryContentItemTests: XCTestCase {

    func testInitWithParagraphContent() {
        let paragraph = StoryParagraph.mockData
        let content = StoryContent.paragraph(paragraph)

        let item = StoryContentItem(content: content)

        switch item {
        case .paragraph(let result):
            XCTAssertEqual(result.text, paragraph.text)

        default:
            XCTFail("Should have created a paragraph StoryContentItem")
        }
    }

    func testInitWithImageContent() {
        let image = StoryImage.mockData
        let content = StoryContent.image(image)

        let item = StoryContentItem(content: content)

        switch item {
        case .image(let result):
            XCTAssertEqual(result.url, image.url)
            XCTAssertEqual(result.accessibilityText, image.accessibilityText)

        default:
            XCTFail("Should have created an image StoryContentItem")
        }
    }

}
