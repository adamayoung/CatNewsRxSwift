//
//  StoryTableViewCell.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import SDWebImage
import UIKit

final class StoryTableViewCell: UITableViewCell {

    static let identifier = "StoryCell"

    var viewModel: StoryListStoryViewModeling? {
        didSet {
            accessibilityValue = "\(viewModel?.headline ?? "")"
            storyImageView.sd_setImage(with: viewModel?.imageURL)
            storyImageView.accessibilityValue = viewModel?.imageAccessibilityText
            headlineLabel.text = viewModel?.headline
            teaserTextLabel.text = viewModel?.teaserText
            dateLabel.text = {
                guard let date = viewModel?.publishedDate else {
                    return nil
                }

                return RelativeDateTimeFormatter.named.localizedString(for: date, relativeTo: Date())
            }()
        }
    }

    private lazy var storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemFill
        imageView.clipsToBounds = true
        imageView.accessibilityLabel = NSLocalizedString("Story image", comment: "Story image")
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

    private lazy var teaserTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 2
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessibilityLabel = NSLocalizedString("Story item", comment: "Story item")

        contentView.layoutMargins.top *= 2
        contentView.layoutMargins.bottom *= 2

        contentView.addSubview(storyImageView)
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            storyImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            storyImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            storyImageView.heightAnchor.constraint(equalToConstant: 50),
            storyImageView.widthAnchor.constraint(equalToConstant: 50),
            storyImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])

        contentView.addSubview(headlineContainer)
        headlineContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            headlineContainer.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            headlineContainer.leadingAnchor.constraint(equalToSystemSpacingAfter: storyImageView.trailingAnchor,
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
            dateLabel.trailingAnchor.constraint(equalTo: headlineContainer.trailingAnchor),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: headlineContainer.bottomAnchor)
        ])
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        contentView.addSubview(teaserTextLabel)
        teaserTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            teaserTextLabel.topAnchor.constraint(equalToSystemSpacingBelow: headlineLabel.bottomAnchor, multiplier: 1),
            teaserTextLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: storyImageView.trailingAnchor,
                                                     multiplier: 1),
            teaserTextLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            teaserTextLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
