//
//  StoryView.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import UIKit

final class StoryView: UIView {

    var viewModel: StoryViewModeling? {
        didSet {
            updateUI()
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StoryView {

    private func updateUI() {
        stackView.arrangedSubviews.forEach(stackView.removeArrangedSubview)
        guard let viewModel = self.viewModel else {
            return
        }

        let headerViewModel = StoryHeaderViewModel(headlineText: viewModel.headline,
                                                   heroImageURL: viewModel.heroImageURL,
                                                   heroImageAccessibilityText: viewModel.heroImageAccessibilityText,
                                                   createdDate: viewModel.creationDate)

        let headerView = StoryHeaderView(viewModel: headerViewModel)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(headerView)
        headerView.addConstraints([
            headerView.heightAnchor.constraint(equalToConstant: 300)
        ])

        let subheaderViewModel = StorySubheaderViewModel(publishedDate: viewModel.creationDate)
        let subheaderView = StorySubheaderView(viewModel: subheaderViewModel)
        subheaderView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(subheaderView)

        viewModel.contents.forEach { content in
            switch content {
            case .paragraph(let viewModel):
                let view = StoryParagraphView(viewModel: viewModel)
                view.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(view)

            case .image(let viewModel):
                let view = StoryImageView(viewModel: viewModel)
                view.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(view)
                view.addConstraints([
                    view.heightAnchor.constraint(equalToConstant: 300)
                ])
            }
        }
    }

}
