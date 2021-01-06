@testable import CatNewsCore
import XCTest

final class StoryTests: XCTestCase {

    var jsonDecoder: JSONDecoder!

    override func setUpWithError() throws {
        jsonDecoder = .catNews
    }

    override func tearDownWithError() throws {
        jsonDecoder = nil
    }

    func testStory1JSONDecode() throws {
        let expectedID = "1"
        let expectedContentsCount = 5

        guard let url = Bundle.module.url(forResource: "MockData/story-1", withExtension: "json") else {
            XCTFail("Can't find MockData/story-1.json")
            return
        }

        let data = try Data(contentsOf: url)

        let result = try jsonDecoder.decode(Story.self, from: data)

        XCTAssertEqual(result.id, expectedID)
        XCTAssertEqual(result.contents.count, expectedContentsCount)
    }

    func testStory2JSONDecode() throws {
        let expectedID = "2"
        let expectedContentsCount = 8

        guard let url = Bundle.module.url(forResource: "MockData/story-2", withExtension: "json") else {
            XCTFail("Can't find MockData/story-2.json")
            return
        }

        let data = try Data(contentsOf: url)

        let result = try jsonDecoder.decode(Story.self, from: data)

        XCTAssertEqual(result.id, expectedID)
        XCTAssertEqual(result.contents.count, expectedContentsCount)
    }

    func testStory4JSONDecode() throws {
        let expectedID = "4"
        let expectedContentsCount = 11

        guard let url = Bundle.module.url(forResource: "MockData/story-4", withExtension: "json") else {
            XCTFail("Can't find MockData/story-4.json")
            return
        }

        let data = try Data(contentsOf: url)

        let result = try jsonDecoder.decode(Story.self, from: data)

        XCTAssertEqual(result.id, expectedID)
        XCTAssertEqual(result.contents.count, expectedContentsCount)
    }

}
