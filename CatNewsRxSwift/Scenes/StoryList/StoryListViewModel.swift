//
//  StoryListViewModel.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import Foundation
import os.log
import RxCocoa
import RxSwift

protocol StoryListViewModeling {

    var title: Driver<String> { get }
    var sections: Driver<[StoriesSection]> { get }
    var isFetching: Driver<Bool> { get }

    func fetch()

}

final class StoryListViewModel: StoryListViewModeling {

    var title: Driver<String> {
        titleSubject.asDriver(onErrorJustReturn: "")
    }

    var sections: Driver<[StoriesSection]> {
        sectionsSubject.asDriver(onErrorJustReturn: [])
    }

    var isFetching: Driver<Bool> {
        isFetchingSubject.asDriver(onErrorJustReturn: false)
    }

    private let disposeBag = DisposeBag()
    private let newsStore: NewsStore
    private let titleSubject = PublishSubject<String>()
    private let sectionsSubject = PublishSubject<[StoriesSection]>()
    private let isFetchingSubject = BehaviorSubject(value: false)

    init(newsStore: NewsStore) {
        self.newsStore = newsStore
    }

    func fetch() {
        os_log("Fetching stories...", log: .app)

        isFetchingSubject.onNext(true)

        newsStore.fetchStoryCollection()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] storyCollection in
                self?.titleSubject.onNext(storyCollection.title)
                let items = storyCollection.data.map(StoryListItemViewModel.init)
                let section = StoriesSection(header: "Stories", items: items)
                self?.sectionsSubject.onNext([section])
                self?.isFetchingSubject.onNext(false)
            }, onFailure: { [weak self] error in
                self?.isFetchingSubject.onNext(false)
            })
            .disposed(by: disposeBag)
    }

}
