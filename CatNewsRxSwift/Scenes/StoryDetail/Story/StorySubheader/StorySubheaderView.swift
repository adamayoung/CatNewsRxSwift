//
//  StorySubheaderView.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import UIKit

final class StorySubheaderView: UIView {

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: StorySubheaderViewModeling) {
        super.init(frame: .zero)

        layoutMargins.left *= 2
        layoutMargins.right *= 2

        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            dateLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])

        dateLabel.text = DateFormatter.fullDate.string(from: viewModel.publishedDate).uppercased()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
