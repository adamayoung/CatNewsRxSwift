//
//  MockNewsStore.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation
import RxSwift

final class MockNewsStore: NewsStore {

    init() { }

    func fetchStoryCollection() -> Single<StoryCollection> {
        Single.create { single in
            DispatchQueue.main.async {
                single(.success(.mockData))
            }

            return Disposables.create { }
        }
    }

    func fetchStory(withID id: String) -> Single<Story?> {
        Single.create { single in
            DispatchQueue.main.async {
                switch id {
                case "1":
                    single(.success(Story.mockData))

                case "3":
                    single(.success(Story.mockData2))

                default:
                    single(.success(nil))
                }
            }

            return Disposables.create { }
        }
    }

}
