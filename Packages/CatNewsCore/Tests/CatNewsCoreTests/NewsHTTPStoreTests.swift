@testable import CatNewsCore
import RxSwift
import XCTest

final class NewsHTTPStoreTests: XCTestCase {

    var disposeBag: DisposeBag!
    var newsStore: NewsHTTPStore!
    var httpClient: MockHTTPClient!

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        httpClient = MockHTTPClient()
        newsStore = NewsHTTPStore(client: httpClient)
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        httpClient = nil
        newsStore = nil
    }

    func testFetchStoryCollectionWhenSuccessReturnsStoryCollection() {
        let expectedResult = StoryCollection.mockData
        let expectedEndpoint: Endpoint = .newsList
        httpClient.getResponse = expectedResult

        let expectation = XCTestExpectation(description: "newsStore.fetchStoryCollection")

        newsStore.fetchStoryCollection()
            .subscribe(onSuccess: { result in
                XCTAssertEqual(result, expectedResult)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(httpClient.lastEndpoint, expectedEndpoint)
    }

    func testFetchStoryCollectionWhenFailureReturnsError() {
        let expectedError = MockError()
        httpClient.getError = expectedError

        let expectation = XCTestExpectation(description: "newsStore.fetchStoryCollection")

        newsStore.fetchStoryCollection()
            .subscribe(onFailure: { error in
                guard let error = error as? MockError else {
                    XCTFail("Error is wrong type")
                    expectation.fulfill()
                    return
                }

                XCTAssertTrue(error === expectedError)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 2)
    }

    func testFetchStoryWhenSuccessReturnsStory() {
        let expectedResult = Story.mockData
        let storyID = expectedResult.id
        let expectedEndpoint: Endpoint = .story(storyID: storyID)
        httpClient.getResponse = expectedResult

        let expectation = XCTestExpectation(description: "newsStore.fetchStory")

        newsStore.fetchStory(withID: storyID)
            .subscribe(onSuccess: { result in
                XCTAssertEqual(result, expectedResult)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(httpClient.lastEndpoint, expectedEndpoint)
    }

    func testFetchStoryWhenSuccessAndNotFoundReturnsNil() {
        let storyID = UUID().uuidString
        httpClient.getError = NotFoundError()

        let expectation = XCTestExpectation(description: "newsStore.fetchStory")

        newsStore.fetchStory(withID: storyID)
            .subscribe(onSuccess: { result in
                XCTAssertNil(result)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 2)
    }

    func testFetchStoryWhenFailureReturnsError() {
        let storyID = UUID().uuidString
        let expectedError = MockError()
        httpClient.getError = expectedError

        let expectation = XCTestExpectation(description: "newsStore.fetchStory")

        newsStore.fetchStory(withID: storyID)
            .subscribe(onFailure: { error in
                guard let error = error as? MockError else {
                    XCTFail("Error is wrong type")
                    return
                }

                XCTAssertTrue(error === expectedError)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 2)
    }

}
