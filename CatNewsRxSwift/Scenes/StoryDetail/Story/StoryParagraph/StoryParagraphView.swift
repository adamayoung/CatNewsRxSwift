//
//  StoryParagraphView.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import UIKit

final class StoryParagraphView: UIView {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: StoryParagraphViewModeling) {
        super.init(frame: .zero)

        layoutMargins.left *= 2
        layoutMargins.right *= 2

        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            textLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])

        textLabel.text = viewModel.text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
