//
//  StoryListTests.swift
//  CatNewsRxSwiftUITests
//
//  Created by Adam Young on 06/01/2021.
//

import XCTest

class StoryListTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()

        app = XCUIApplication()
        app.launchArguments = [
            "SKIP_ANIMATIONS",
            "UI_TEST"
        ]

        app.launch()
    }

    func testLoadsStories() throws {
        let table = app.tables["Stories"]
        XCTAssertTrue(table.exists)
        XCTAssertEqual(table.cells.count, 4)
    }

    func testNavigatesToMainStory() throws {
        let cell = app.tables["Stories"].cells["Main Story item"].firstMatch
        XCTAssertTrue(cell.exists)
        cell.tap()

        let storyView = app.scrollViews["Story"]
        guard storyView.waitForExistence(timeout: 5) else {
            XCTFail("Story view didn't load")
                return
        }

        let headlineLabel = storyView.otherElements.staticTexts["Headline 1"]
        XCTAssertTrue(headlineLabel.exists)
    }

    func testNavigatesToWeblink() throws {
        let cell = app.tables["Stories"].cells["Weblink item"].firstMatch
        XCTAssertTrue(cell.exists)
        cell.tap()

        let webView = app.otherElements["Weblink view"]
        guard webView.waitForExistence(timeout: 5) else {
            XCTFail("Web view didn't load")
                return
        }

        XCTAssertTrue(webView.exists)
    }

    func testNavigatesToStory() throws {
        let cell = app.tables["Stories"].cells["Story item"].firstMatch
        XCTAssertTrue(cell.exists)
        cell.tap()

        let storyView = app.scrollViews["Story"]
        guard storyView.waitForExistence(timeout: 5) else {
            XCTFail("Story view didn't load")
                return
        }

        let headlineLabel = storyView.otherElements.staticTexts["Headline 3"]
        XCTAssertTrue(headlineLabel.exists)
    }

}
