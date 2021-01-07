//
//  MockTestNewsStore.swift
//  CatNewsRxSwiftTests
//
//  Created by Adam Young on 07/01/2021.
//

import CatNewsCore
import Foundation
import RxSwift

final class MockTestNewsStore: NewsStore {

    var fetchStoryCollectionResult: Result<StoryCollection, Error>?
    var fetchStoreLastID: String?
    var fetchStoryResult: Result<Story?, Error>?

    func fetchStoryCollection() -> Single<StoryCollection> {
        guard let result = fetchStoryCollectionResult else {
            fatalError("fetchStoryCollectionResult not set")
        }

        return Single.create { single in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                single(result)
            }

            return Disposables.create { }
        }
    }

    func fetchStory(withID id: String) -> Single<Story?> {
        fetchStoreLastID = id

        guard let result = fetchStoryResult else {
            fatalError("fetchStoryResult not set")
        }

        return Single.create { single in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                single(result)
            }

            return Disposables.create { }
        }
    }

}
