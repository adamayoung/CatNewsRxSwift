@testable import CatNewsCore
import XCTest

final class NewsHTTPStoreTests: XCTestCase {

    var newsStore: NewsHTTPStore!
    var httpClient: MockHTTPClient!

    override func setUpWithError() throws {
        httpClient = MockHTTPClient()
        newsStore = NewsHTTPStore(client: httpClient)
    }

    override func tearDownWithError() throws {
        httpClient = nil
        newsStore = nil
    }

    func testFetchStoryCollectionWhenSuccessReturnsStoryCollection() {
        let expectedResult = mockStoryCollection
        let expectedEndpoint: Endpoint = .newsList
        httpClient.getResponse = expectedResult

        let expectation = XCTestExpectation(description: "newsStore.fetchStoryCollection")
        newsStore.fetchStoryCollection { resultResult in
            let result = try? resultResult.get()
            XCTAssertEqual(result, expectedResult)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(httpClient.lastEndpoint, expectedEndpoint)
    }

    func testFetchStoryCollectionWhenFailureReturnsError() {
        let expectedError = MockError()
        httpClient.getError = expectedError

        let expectation = XCTestExpectation(description: "newsStore.fetchStoryCollection")
        newsStore.fetchStoryCollection { resultResult in
            do {
                _ = try resultResult.get()
            } catch let error {
                guard let error = error as? MockError else {
                    XCTFail("Error is wrong type")
                    return
                }

                XCTAssertTrue(error === expectedError)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchStoryWhenSuccessReturnsStory() {
        let storyID = UUID().uuidString
        let expectedResult = mockStory
        let expectedEndpoint: Endpoint = .story(storyID: storyID)
        httpClient.getResponse = expectedResult

        let expectation = XCTestExpectation(description: "newsStore.fetchStory")
        newsStore.fetchStory(withID: storyID) { resultResult in
            let result = try? resultResult.get()
            XCTAssertEqual(result, expectedResult)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(httpClient.lastEndpoint, expectedEndpoint)
    }

    func testFetchStoryWhenSuccessAndNotFoundReturnsNil() {
        let storyID = UUID().uuidString
        httpClient.getError = NotFoundError()

        let expectation = XCTestExpectation(description: "newsStore.fetchStory")
        newsStore.fetchStory(withID: storyID) { resultResult in
            let result = try? resultResult.get()
            XCTAssertNil(result)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchStoryWhenFailureReturnsError() {
        let storyID = UUID().uuidString
        let expectedError = MockError()
        httpClient.getError = expectedError

        let expectation = XCTestExpectation(description: "newsStore.fetchStory")
        newsStore.fetchStory(withID: storyID) { resultResult in
            do {
                _ = try resultResult.get()
            } catch let error {
                guard let error = error as? MockError else {
                    XCTFail("Error is wrong type")
                    return
                }

                XCTAssertTrue(error === expectedError)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

}
