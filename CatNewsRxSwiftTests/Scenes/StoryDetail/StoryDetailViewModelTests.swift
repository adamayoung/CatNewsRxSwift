//
//  StoryDetailViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import RxSwift
import XCTest

class StoryDetailViewModelTests: XCTestCase {

    var disposeBag: DisposeBag!
    var viewModel: StoryDetailViewModel!
    var storyID: String!
    var newsStore: MockTestNewsStore!

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        storyID = Story.mockData.id
        newsStore = MockTestNewsStore()
        viewModel = StoryDetailViewModel(storyID: storyID, newsStore: newsStore)
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        storyID = nil
        newsStore = nil
        viewModel = nil
    }

    func testInitSetsStoryID() {
        XCTAssertEqual(viewModel.storyID, storyID)
    }

    func testFetchWhenFetchSuccessSetStory() {
        let story = Story.mockData
        newsStore.fetchStoryResult = .success(story)
        let expectedResult = StoryViewModel(story: story)

        let expectation = XCTestExpectation(description: "viewModel.fetch")

        viewModel.story
            .subscribe(onNext: { story in
                XCTAssertEqual(story.id, expectedResult.id)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.fetch()
        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(self.newsStore.fetchStoreLastID, self.storyID)
    }

    func testFetchWhenFetchSuccessAndNilSetFetchError() {
        newsStore.fetchStoryResult = .success(nil)

        let expectation = XCTestExpectation(description: "viewModel.fetch")

        viewModel.fetchError
            .skip(1)
            .subscribe(onNext: { error in
                XCTAssertTrue(error is StoryDetailViewModel.StoryNotFoundError)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.fetch()
        wait(for: [expectation], timeout: 2)
    }

    func testFetchWHenFetchSuccessSetsFetchError() {
        let expectedError = MockFetchError()
        newsStore.fetchStoryResult = .failure(expectedError)

        let expectation = XCTestExpectation(description: "viewModel.fetch")

        viewModel.fetchError
            .skip(1)
            .subscribe(onNext: { error in
                guard let fetchError = error as? MockFetchError else {
                    XCTFail("error is not a MockFetchError")
                    return
                }

                XCTAssertTrue(fetchError === expectedError)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.fetch()
        wait(for: [expectation], timeout: 2)
    }

}
