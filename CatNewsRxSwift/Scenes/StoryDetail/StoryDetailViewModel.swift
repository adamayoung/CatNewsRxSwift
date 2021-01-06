//
//  StoryDetailViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation
import os.log
import RxSwift

protocol StoryDetailViewModeling {

    var storyID: String { get }
    var story: Observable<StoryViewModel> { get }
    var isFetching: Observable<Bool> { get }
    var fetchError: Observable<Error?> { get }

    func fetch()

}

final class StoryDetailViewModel: StoryDetailViewModeling {

    let storyID: String

    var story: Observable<StoryViewModel> {
        storySubject.asObservable()
    }

    var isFetching: Observable<Bool> {
        isFetchingSubject.asObservable()
    }

    var fetchError: Observable<Error?> {
        fetchErrorSubject.asObservable()
    }

    private let disposeBag = DisposeBag()
    private let newsStore: NewsStore
    private let storySubject = PublishSubject<StoryViewModel>()
    private let isFetchingSubject = BehaviorSubject(value: false)
    private let fetchErrorSubject = PublishSubject<Error?>()

    init(storyID: String, newsStore: NewsStore) {
        self.storyID = storyID
        self.newsStore = newsStore
    }

    func fetch() {
        os_log("Fetching story %@...", log: .app, storyID)

        fetchErrorSubject.onNext(nil)
        isFetchingSubject.onNext(true)

        newsStore.fetchStory(withID: storyID)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] story in
                guard let self = self else {
                    return
                }

                self.isFetchingSubject.onNext(false)

                guard let story = story else {
                    os_log("Story %@ not found", log: .app, type: .error, self.storyID)
                    self.fetchErrorSubject.onNext(StoryNotFoundError())
                    return
                }

                self.storySubject.onNext(StoryViewModel(story: story))
            }, onFailure: { [weak self] error in
                guard let self = self else {
                    return
                }

                self.isFetchingSubject.onNext(false)

                os_log("Error fetching story %@: %@", log: .app, type: .error, self.storyID, error.localizedDescription)
                self.fetchErrorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }

}

extension StoryDetailViewModel {

    struct StoryNotFoundError: Error { }

}
