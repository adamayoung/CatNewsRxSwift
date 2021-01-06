//
//  StoryListViewController.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
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

        tableView.refreshControl = UIRefreshControl()
        tableView.register(MainStoryTableViewCell.self, forCellReuseIdentifier: MainStoryTableViewCell.identifier)
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
        tableView.register(WeblinkTableViewCell.self, forCellReuseIdentifier: WeblinkTableViewCell.identifier)
        tableView.register(AdvertTableViewCell.self, forCellReuseIdentifier: AdvertTableViewCell.identifier)

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
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)

        if let refreshControl = refreshControl {
            viewModel.isFetching
                .drive(refreshControl.rx.isRefreshing)
                .disposed(by: disposeBag)
        }

        let dataSource = RxTableViewSectionedAnimatedDataSource<StoriesSection>(configureCell: configureCell)
        self.dataSource = dataSource

        viewModel.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.didSelectRowAtIndexPath(indexPath)
            })
            .disposed(by: disposeBag)
    }

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
