//
//  FeedCellViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class FeedCellViewController: UIViewController {

    private let sentimentIconViewController = SentimentIconViewController()

    private let avatarLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 40)
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
    }
    private var sentimentIconView: UIView {
        return sentimentIconViewController.view
    }

    private let stackView: UIStackView = create {
        $0.alignment = .center
        $0.spacing = 2
        $0.axis = .horizontal
    }
    private let nameLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    private let usernameLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    private let dotLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.text = "·"
    }
    private let dateLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private let contentLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
    }

    var quack: Quack? { didSet { update(with: quack) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension FeedCellViewController {

    private func update(with quack: Quack?) {
        avatarLabel.text = quack?.user.avatar
        nameLabel.text = quack?.user.fullName
        usernameLabel.text = (quack?.user.username).map { "@\($0)" }
        dateLabel.text = "1h"
        contentLabel.text = quack?.text
        sentimentIconViewController.sentiment = quack?.sentiment
    }

    private func setupView() {
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        addChild(sentimentIconViewController)
        sentimentIconViewController.didMove(toParent: self)
        setupLayuot()
    }

    private func setupLayuot() {
        [avatarLabel, stackView, contentLabel, sentimentIconView].forEach(view.addSubview)
        [nameLabel, usernameLabel, dotLabel, dateLabel].forEach(stackView.addArrangedSubview)
        NSLayoutConstraint.activate([
            avatarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            avatarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            avatarLabel.heightAnchor.constraint(equalToConstant: 44),
            avatarLabel.widthAnchor.constraint(equalTo: avatarLabel.heightAnchor, multiplier: 1),

            sentimentIconView.leadingAnchor.constraint(equalTo: avatarLabel.leadingAnchor, constant: 6),
            sentimentIconView.topAnchor.constraint(equalTo: avatarLabel.bottomAnchor, constant: 8),
            sentimentIconView.trailingAnchor.constraint(equalTo: avatarLabel.trailingAnchor, constant: -6),
            sentimentIconView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -8),

            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: avatarLabel.trailingAnchor, constant: 4),

            contentLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            contentLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            contentLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
        ])
    }

}
