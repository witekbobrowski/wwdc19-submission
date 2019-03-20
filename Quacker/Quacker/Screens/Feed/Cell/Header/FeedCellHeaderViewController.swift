//
//  FeedCellHeaderViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class FeedCellHeaderViewController: UIViewController {

    private let stackView: UIStackView = create {
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.spacing = 2
        $0.axis = .horizontal
    }
    private let nameLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    private let usernameLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = StyleSheet.Color.secondaryTextColor
        $0.setContentHuggingPriority(.required, for: .horizontal)
    }
    private let dotLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = StyleSheet.Color.secondaryTextColor
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        $0.text = "·"
    }
    private let dateLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = StyleSheet.Color.secondaryTextColor
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    var quack: Quack? { didSet { update(with: quack) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension FeedCellHeaderViewController {

    private func update(with quack: Quack?) {
        nameLabel.text = quack?.user.fullName
        usernameLabel.text = (quack?.user.username).map { "@\($0)" }
        dateLabel.text = "1h"
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        setupLayuot()
    }

    private func setupLayuot() {
        view.addSubview(stackView)
        [nameLabel, usernameLabel, dotLabel, dateLabel].forEach(stackView.addArrangedSubview)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }

}
