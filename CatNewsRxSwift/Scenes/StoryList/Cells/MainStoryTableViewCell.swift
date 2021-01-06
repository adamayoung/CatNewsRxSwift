//
//  MainStoryTableViewCell.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import SDWebImage
import UIKit

final class MainStoryTableViewCell: UITableViewCell {

    static let identifier = "MainStoryCell"

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
        imageView.backgroundColor = UIColor.secondarySystemFill
        imageView.clipsToBounds = true
        imageView.sd_imageTransition = SDWebImageTransition.fade
        imageView.accessibilityLabel = NSLocalizedString("Story image", comment: "Story image")
        return imageView
    }()

    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        return label
    }()

    private lazy var teaserTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessibilityLabel = NSLocalizedString("Main Story item", comment: "Main Story item")

        contentView.layoutMargins.top *= 2
        contentView.layoutMargins.bottom *= 2

        contentView.addSubview(storyImageView)
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            storyImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            storyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storyImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            storyImageView.heightAnchor.constraint(equalToConstant: 250)
        ])

        contentView.addSubview(headlineLabel)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            headlineLabel.topAnchor.constraint(equalToSystemSpacingBelow: storyImageView.bottomAnchor, multiplier: 1),
            headlineLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])

        contentView.addSubview(teaserTextLabel)
        teaserTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            teaserTextLabel.topAnchor.constraint(equalToSystemSpacingBelow: headlineLabel.bottomAnchor, multiplier: 1),
            teaserTextLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            teaserTextLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])

        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: teaserTextLabel.bottomAnchor, multiplier: 1),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
