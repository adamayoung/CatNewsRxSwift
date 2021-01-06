//
//  StoryHeaderView.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import SDWebImage
import UIKit

final class StoryHeaderView: UIView {

    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemFill
        imageView.sd_imageTransition = SDWebImageTransition.fade
        return imageView
    }()

    private lazy var headlingLabelBackground: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.systemGray.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }()

    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    init(viewModel: StoryHeaderViewModeling) {
        super.init(frame: .zero)

        layoutMargins.left *= 2
        layoutMargins.right *= 2

        addSubview(heroImageView)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(headlingLabelBackground)
        headlingLabelBackground.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            headlingLabelBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            headlingLabelBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            headlingLabelBackground.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            headlineLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            headlineLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            headlingLabelBackground.topAnchor.constraint(equalTo: headlineLabel.topAnchor, constant: -50)
        ])

        heroImageView.sd_setImage(with: viewModel.heroImageURL)
        heroImageView.accessibilityLabel = NSLocalizedString("Main story image", comment: "Main story image")
        heroImageView.accessibilityValue = viewModel.heroImageAccessibilityText
        headlineLabel.text = viewModel.headlineText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        headlingLabelBackground.layer.sublayers?.first?.frame = headlingLabelBackground.bounds
    }

}
