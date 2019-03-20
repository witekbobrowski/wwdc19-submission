//
//  FeedCellViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class FeedCellViewController: UIViewController {

    private let avatarViewController = FeedCellAvatarViewController()
    private let sentimentIconViewController = SentimentIconViewController()
    private let headerViewController = FeedCellHeaderViewController()

    private var avatarView: UIView {
        return avatarViewController.view
    }
    private var sentimentIconView: UIView {
        return sentimentIconViewController.view
    }
    private var headerView: UIView {
        return headerViewController.view
    }
    private let contentLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = StyleSheet.Color.textColor
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
        avatarViewController.avatar = quack?.user.avatar
        contentLabel.text = quack?.text
        headerViewController.quack = quack
        sentimentIconViewController.sentiment = quack?.sentiment
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addChild(sentimentIconViewController)
        sentimentIconViewController.didMove(toParent: self)
        setupLayuot()
    }

    private func setupLayuot() {
        [avatarView, headerView, contentLabel, sentimentIconView].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            avatarView.heightAnchor.constraint(equalToConstant: 44),
            avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor, multiplier: 1),

            sentimentIconView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor, constant: 6),
            sentimentIconView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 8),
            sentimentIconView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: -6),
            sentimentIconView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -8),

            headerView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            headerView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8),

            contentLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            contentLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 4),
            contentLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
        ])
    }

}
