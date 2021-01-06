//
//  StoryListViewController.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import Differentiator
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class StoryListViewController: UITableViewController {

    var didSelectStory: Observable<String> {
        selectStorySubject.asObservable()
    }

    var didSelectWebLink: Observable<URL> {
        selectWebLinkSubject.asObservable()
    }

    private let disposeBag = DisposeBag()
    private let viewModel: StoryListViewModeling
    private let selectStorySubject = PublishSubject<String>()
    private let selectWebLinkSubject = PublishSubject<URL>()

    private var dataSource: RxTableViewSectionedAnimatedDataSource<StoriesSection>?

    init(viewModel: StoryListViewModeling) {
        self.viewModel = viewModel

        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.accessibilityLabel = NSLocalizedString("Stories", comment: "Stories")
        tableView.register(MainStoryTableViewCell.self, forCellReuseIdentifier: MainStoryTableViewCell.identifier)
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
        tableView.register(WeblinkTableViewCell.self, forCellReuseIdentifier: WeblinkTableViewCell.identifier)
        tableView.register(AdvertTableViewCell.self, forCellReuseIdentifier: AdvertTableViewCell.identifier)

        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.dataSource = nil
        tableView.delegate = nil

        setupBindings()

        viewModel.fetch()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource?[indexPath] else {
            return 0
        }

        switch item {
        case .advert:
            return tableView.frame.width * 0.3

        default:
            return UITableView.automaticDimension
        }
    }

}

extension StoryListViewController {

    private func setupBindings() {
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.isFetching
            .subscribe(onNext: { [weak self] isFetching in
                self?.showLoading(isFetching)
            })
            .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedAnimatedDataSource<StoriesSection>(configureCell: configureCell)
        self.dataSource = dataSource

        viewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.sections
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.addRefreshControl()
            })
            .disposed(by: disposeBag)

        viewModel.fetchError
            .subscribe(onNext: { [weak self] error in
                self?.displayError(error)
            })
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.didSelectRowAtIndexPath(indexPath)
            })
            .disposed(by: disposeBag)
    }

    private func addRefreshControl() {
        guard self.refreshControl == nil else {
            return
        }

        let refreshControl = UIRefreshControl()
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.fetch()
            })
            .disposed(by: disposeBag)

        self.refreshControl = refreshControl
    }

}

extension StoryListViewController {

    private func configureCell(dataSource: TableViewSectionedDataSource<StoriesSection>, tableView: UITableView,
                               indexPath: IndexPath, item: StoryListItemViewModel) -> UITableViewCell {
        switch item {
        case .story(let viewModel):
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MainStoryTableViewCell.identifier,
                                                               for: indexPath) as? MainStoryTableViewCell
                else {
                    fatalError()
                }

                cell.viewModel = viewModel
                cell.setNeedsUpdateConstraints()
                cell.updateConstraints()
                return cell
            }

            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier,
                                                           for: indexPath) as? StoryTableViewCell
            else {
                fatalError()
            }

            cell.viewModel = viewModel
            return cell

        case .weblink(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeblinkTableViewCell.identifier,
                                                           for: indexPath) as? WeblinkTableViewCell
            else {
                fatalError()
            }

            cell.viewModel = viewModel
            return cell

        case .advert(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdvertTableViewCell.identifier,
                                                           for: indexPath) as? AdvertTableViewCell
            else {
                fatalError()
            }

            cell.viewModel = viewModel
            return cell
        }
    }

    private func didSelectRowAtIndexPath(_ indexPath: IndexPath) {
        guard let item = dataSource?[indexPath] else {
            return
        }

        switch item {
        case .story(let viewModel):
            selectStorySubject.onNext(viewModel.id)

        case .weblink(let viewModel):
            selectWebLinkSubject.onNext(viewModel.url)

        default:
            return
        }
    }

}

extension StoryListViewController {

    private func showLoading(_ loading: Bool) {
        if !loading {
            tableView.separatorColor = .separator
            tableView.backgroundView = nil
        }

        if let refreshControl = self.refreshControl {
            if loading {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }

            return
        }

        tableView.separatorColor = .clear
        tableView.backgroundView = LoadingView(message: NSLocalizedString("Loading", comment: "Loading"))
    }

    private func displayError(_ error: Error?) {
        tableView.backgroundView = nil

        guard error != nil else {
            return
        }

        let errorView = ErrorView(
            title: NSLocalizedString("What a CATastrophe", comment: "What a CATastrophe"),
            message: NSLocalizedString("There's been a problem fetching the latest news articles",
                                       comment: "There's been a problem fetching the latest news articles"),
            retryHandler: { [weak self] in
                self?.viewModel.fetch()
            }
        )
        tableView.backgroundView = errorView
        tableView.separatorColor = .clear
    }

}
