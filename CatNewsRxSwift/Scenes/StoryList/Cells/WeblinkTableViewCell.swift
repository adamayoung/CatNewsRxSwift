//
//  WeblinkTableViewCell.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import SDWebImage
import UIKit

final class WeblinkTableViewCell: UITableViewCell {

    static let identifier = "WeblinkCell"

    var viewModel: StoryListWeblinkViewModeling? {
        didSet {
            accessibilityValue = "\(viewModel?.headline ?? "")"
            weblinkImageView.sd_setImage(with: viewModel?.imageURL)
            weblinkImageView.accessibilityLabel = viewModel?.imageAccessibilityText
            headlineLabel.text = viewModel?.headline
            linkURLLabel.text = viewModel?.url.host
            dateLabel.text = {
                guard let date = viewModel?.publishedDate else {
                    return nil
                }

                return RelativeDateTimeFormatter.named.localizedString(for: date, relativeTo: Date())
            }()
        }
    }

    private lazy var weblinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemFill
        imageView.clipsToBounds = true
        imageView.sd_imageTransition = SDWebImageTransition.fade
        imageView.accessibilityLabel = NSLocalizedString("Weblink image", comment: "Weblink image")
        return imageView
    }()

    private lazy var headlineContainer = UIView()

    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()

    private lazy var linkURLLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessibilityLabel = NSLocalizedString("Weblink item", comment: "Weblink item")

        contentView.layoutMargins.top *= 2
        contentView.layoutMargins.bottom *= 2

        contentView.addSubview(weblinkImageView)
        weblinkImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            weblinkImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            weblinkImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            weblinkImageView.heightAnchor.constraint(equalToConstant: 50),
            weblinkImageView.widthAnchor.constraint(equalToConstant: 50),
            weblinkImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])

        contentView.addSubview(headlineContainer)
        headlineContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            headlineContainer.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            headlineContainer.leadingAnchor.constraint(equalToSystemSpacingAfter: weblinkImageView.trailingAnchor,
                                                   multiplier: 1),
            headlineContainer.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])

        headlineContainer.addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineContainer.addConstraints([
            headlineLabel.topAnchor.constraint(equalTo: headlineContainer.topAnchor),
            headlineLabel.leadingAnchor.constraint(equalTo: headlineContainer.leadingAnchor),
            headlineLabel.bottomAnchor.constraint(equalTo: headlineContainer.bottomAnchor)
        ])

        headlineContainer.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineContainer.addConstraints([
            dateLabel.topAnchor.constraint(equalTo: headlineContainer.topAnchor),
            dateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: headlineLabel.trailingAnchor, multiplier: 1),
            dateLabel.trailingAnchor.constraint(equalTo: headlineContainer.trailingAnchor)
        ])
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        contentView.addSubview(linkURLLabel)
        linkURLLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            linkURLLabel.topAnchor.constraint(equalToSystemSpacingBelow: headlineLabel.bottomAnchor, multiplier: 1),
            linkURLLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: weblinkImageView.trailingAnchor,
                                                     multiplier: 1),
            linkURLLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            linkURLLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
