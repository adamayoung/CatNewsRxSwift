//
//  ErrorView.swift
//  CatNewsRxSwift
//
//  Created by Adam Young on 06/01/2021.
//

import RxCocoa
import RxSwift
import UIKit

final class ErrorView: UIView {

    private let disposeBag = DisposeBag()

    private lazy var container = UIView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Retry", comment: "Retry"), for: .normal)
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        return button
    }()

    private let retryHandler: (() -> Void)?

    init(title: String, message: String, retryHandler: (() -> Void)? = nil) {
        self.retryHandler = retryHandler
        super.init(frame: .zero)

        container.layoutMargins.left *= 5
        container.layoutMargins.right *= 5

        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 1)
        ])

        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraints([
            titleLabel.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor)
        ])

        container.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraints([
            messageLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            messageLabel.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor)
        ])

        if retryHandler != nil {
            container.addSubview(retryButton)
            retryButton.translatesAutoresizingMaskIntoConstraints = false
            container.addConstraints([
                retryButton.topAnchor.constraint(equalToSystemSpacingBelow: messageLabel.bottomAnchor, multiplier: 3),
                retryButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                retryButton.bottomAnchor.constraint(equalTo: container.layoutMarginsGuide.bottomAnchor)
            ])
        } else {
            container.addConstraints([
                messageLabel.bottomAnchor.constraint(equalTo: container.layoutMarginsGuide.bottomAnchor)
            ])
        }

        titleLabel.text = title
        messageLabel.text = message

        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ErrorView {

    private func setupBindings() {
        if retryHandler != nil {
            retryButton.rx.controlEvent(.touchUpInside)
                .subscribe(onNext: { [weak self] in
                    self?.retryHandler?()
                })
                .disposed(by: disposeBag)
        }
    }

}
