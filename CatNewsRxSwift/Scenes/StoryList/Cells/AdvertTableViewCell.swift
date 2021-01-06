//
//  AdvertTableViewCell.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import SDWebImage
import UIKit

final class AdvertTableViewCell: UITableViewCell {

    static let identifier = "AdvertCell"

    var viewModel: StoryListAdvertViewModeling? {
        didSet {
            accessibilityValue = viewModel?.url.absoluteString ?? ""
            advertImageView.sd_setImage(with: viewModel?.url)
        }
    }

    private lazy var advertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemFill
        imageView.clipsToBounds = true
        imageView.sd_imageTransition = SDWebImageTransition.fade
        imageView.accessibilityLabel = NSLocalizedString("Advert image", comment: "Advert image")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessibilityLabel = "Advert"

        contentView.addSubview(advertImageView)
        advertImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            advertImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            advertImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            advertImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            advertImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
