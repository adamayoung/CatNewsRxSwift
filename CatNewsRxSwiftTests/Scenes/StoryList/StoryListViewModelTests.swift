//
//  StoryListViewModelTests.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
@testable import CatNewsRxSwift
import RxSwift
import XCTest

class StoryListViewModelTests: XCTestCase {

    var disposeBag: DisposeBag!
    var viewModel: StoryListViewModel!
    var newsStore: MockTestNewsStore!

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        newsStore = MockTestNewsStore()
        viewModel = StoryListViewModel(newsStore: newsStore)
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        newsStore = nil
        viewModel = nil
    }

    func testFetchWhenFetchSuccessSetsSections() {
        let storyCollection = StoryCollection.mockData
        newsStore.fetchStoryCollectionResult = .success(storyCollection)
        let expectedResult = storyCollection.data.count

        let expectation = XCTestExpectation(description: "viewModel.fetch")

        viewModel.sections
            .take(1)
            .subscribe(onNext: { sections in
                let section = sections.first
                let result = section?.items.count
                XCTAssertEqual(result, expectedResult)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.fetch()
        wait(for: [expectation], timeout: 2)
    }

    func testFetchWhenFetchSuccessSetsTitle() {
        let storyCollection = StoryCollection.mockData
        newsStore.fetchStoryCollectionResult = .success(storyCollection)
        let expectedResult = storyCollection.title

        let expectation = XCTestExpectation(description: "viewModel.fetch")

        viewModel.title
            .take(1)
            .subscribe(onNext: { title in
                XCTAssertEqual(title, expectedResult)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.fetch()
        wait(for: [expectation], timeout: 2)
    }

    func testFetchWhenFetchFailsSetsFetchError() {
        let expectedError = MockFetchError()
        newsStore.fetchStoryCollectionResult = .failure(expectedError)

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
