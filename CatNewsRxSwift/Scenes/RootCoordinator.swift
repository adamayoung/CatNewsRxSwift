//
//  RootCoordinator.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import os.log
import RxSwift
import SafariServices
import UIKit

protocol RootCoordinating: Coordinating { }

final class RootCoordinator: RootCoordinating {

    private let disposeBag = DisposeBag()
    private let navigationController: UINavigationController
    private let diContainer: DIContainer

    init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }

    func start() {
        os_log("Starting root coordinator", log: .app)
        let viewController: StoryListViewController = diContainer.resolve()
        viewController.didSelectStory
            .subscribe { [weak self] storyID in
                self?.showStory(storyID)
            }
            .disposed(by: disposeBag)

        viewController.didSelectWebLink
            .subscribe { [weak self] url in
                self?.showWebLink(url)
            }
            .disposed(by: disposeBag)

        navigationController.viewControllers = [viewController]
    }

}

extension RootCoordinator {

    func showStory(_ storyID: String) {
        os_log("Viewing story %@", log: .app, storyID)
        let viewController: StoryDetailViewController = diContainer.resolve(storyID: storyID)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showWebLink(_ url: URL) {
        os_log("Viewing weblink %@", log: .app, url.absoluteString)
        let viewController = SFSafariViewController(url: url)
        viewController.view.accessibilityLabel = "Web view - \(url.absoluteString)"
        navigationController.present(viewController, animated: true, completion: nil)
    }

}
