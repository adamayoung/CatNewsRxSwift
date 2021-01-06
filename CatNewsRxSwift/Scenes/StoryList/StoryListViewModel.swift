//
//  StoryListViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation
import os.log
import RxSwift

protocol StoryListViewModeling {

    var title: Observable<String> { get }
    var sections: Observable<[StoriesSection]> { get }
    var isFetching: Observable<Bool> { get }
    var fetchError: Observable<Error?> { get }

    func fetch()

}

final class StoryListViewModel: StoryListViewModeling {

    var title: Observable<String> {
        titleSubject.asObservable()
    }

    var sections: Observable<[StoriesSection]> {
        sectionsSubject.asObservable()
    }

    var isFetching: Observable<Bool> {
        isFetchingSubject.asObservable()
    }

    var fetchError: Observable<Error?> {
        fetchErrorSubject.asObservable()
    }

    private let disposeBag = DisposeBag()
    private let newsStore: NewsStore
    private let titleSubject = PublishSubject<String>()
    private let sectionsSubject = PublishSubject<[StoriesSection]>()
    private let isFetchingSubject = BehaviorSubject(value: false)
    private let fetchErrorSubject = PublishSubject<Error?>()

    init(newsStore: NewsStore) {
        self.newsStore = newsStore
    }

    func fetch() {
        guard !((try? isFetchingSubject.value()) ?? false) else {
            return
        }

        os_log("Fetching stories...", log: .app)

        fetchErrorSubject.onNext(nil)
        isFetchingSubject.onNext(true)

        newsStore.fetchStoryCollection()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] storyCollection in
                self?.titleSubject.onNext(storyCollection.title)
                let items = storyCollection.data.map(StoryListItemViewModel.init)
                let section = StoriesSection(header: "Stories", items: items)
                self?.sectionsSubject.onNext([section])
                self?.isFetchingSubject.onNext(false)
                os_log("Fetched %d stories", log: .app, storyCollection.data.count)
            }, onFailure: { [weak self] error in
                self?.isFetchingSubject.onNext(false)
                self?.fetchErrorSubject.onNext(error)
                os_log("Error fetching stories: %@", log: .app, type: .error, error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

}
