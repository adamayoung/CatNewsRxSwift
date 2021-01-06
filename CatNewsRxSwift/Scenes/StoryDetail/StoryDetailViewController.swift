//
//  StoryDetailViewController.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import RxSwift
import UIKit

final class StoryDetailViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel: StoryDetailViewModeling

    private lazy var storyView = StoryView()
    private lazy var loadingView = LoadingView(message: NSLocalizedString("Loading story", comment: "Loading story"))

    init(viewModel: StoryDetailViewModeling) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIScrollView()
        view.accessibilityLabel = "Story"
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let view = self.view as? UIScrollView else {
            return
        }

        view.addSubview(storyView)
        storyView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            storyView.topAnchor.constraint(equalTo: view.topAnchor),
            storyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            storyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            storyView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        setupBinding()

        viewModel.fetch()
    }

}

extension StoryDetailViewController {

    private func setupBinding() {
        viewModel.story
            .map(\.headline)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.story
            .subscribe { [weak self] viewModel in
                self?.storyView.viewModel = viewModel
            }
            .disposed(by: disposeBag)

        viewModel.isFetching
            .distinctUntilChanged()
            .subscribe { [weak self] isFetching in
                self?.showLoading(isFetching)
            }
            .disposed(by: disposeBag)

        viewModel.fetchError
            .subscribe { [weak self] error in
                self?.displayError(error)
            }
            .disposed(by: disposeBag)
    }

    private func showLoading(_ loading: Bool) {
        if !loading {
            if loadingView.superview != nil {
                loadingView.removeFromSuperview()
            }

            return
        }

        guard loadingView.superview == nil else {
            return
        }

        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func displayError(_ error: Error?) {
        guard let error = error else {
            view.subviews.forEach { subview in
                if subview is ErrorView {
                    subview.removeFromSuperview()
                }
            }

            return
        }

        let errorView: ErrorView = {
            if error is StoryDetailViewModel.StoryNotFoundError {
                return ErrorView(
                    title: NSLocalizedString("Not found", comment: "Not found"),
                    message: NSLocalizedString("Looks like a cat has made off with this story",
                                               comment: "Looks like a cat has made off with this story")
                )
            }

            return ErrorView(
                title: NSLocalizedString("What a CATastrophe", comment: "What a CATastrophe"),
                message: NSLocalizedString("There's been a problem fetching this news article",
                                           comment: "There's been a problem fetching this news article"),
                retryHandler: { [weak self] in
                    self?.viewModel.fetch()
                }
            )
        }()

        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
