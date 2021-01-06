@testable import CatNewsCore
import XCTest

final class StoryCollectionTests: XCTestCase {

    var jsonDecoder: JSONDecoder!

    override func setUpWithError() throws {
        jsonDecoder = .catNews
    }

    override func tearDownWithError() throws {
        jsonDecoder = nil
    }

    func testStoryCollectionJSONDecode() throws {
        let expectedTitle = "Sky Cat News"
        let expectedDataCount = 6

        guard let url = Bundle.module.url(forResource: "MockData/news-list", withExtension: "json") else {
            XCTFail("Can't find MockData/nest-list.json")
            return
        }

        let data = try Data(contentsOf: url)

        let result = try jsonDecoder.decode(StoryCollection.self, from: data)

        XCTAssertEqual(result.title, expectedTitle)
        XCTAssertEqual(result.data.count, expectedDataCount)
    }

}
