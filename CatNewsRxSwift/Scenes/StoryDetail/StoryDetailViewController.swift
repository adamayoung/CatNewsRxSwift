//
//  StoryDetailViewController.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import CatNewsCore
import UIKit

final class StoryDetailViewController: UIViewController {

    private let viewModel: StoryDetailViewModeling

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

    }

}
