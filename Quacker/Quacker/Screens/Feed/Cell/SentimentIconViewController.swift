//
//  SentimentIconViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class SentimentIconViewController: UIViewController {

    private let iconLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 40)
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
    }

    var sentiment: Sentiment? { didSet { update(with: sentiment) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension SentimentIconViewController {

    private func update(with sentiment: Sentiment?) {
        iconLabel.text = "😭"
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        setupLayuot()
    }

    private func setupLayuot() {
        view.addSubview(iconLabel)
        let offset: CGFloat = 4
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: offset),
            iconLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            iconLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            iconLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset),
            iconLabel.widthAnchor.constraint(equalTo: iconLabel.heightAnchor, multiplier: 1),
        ])
    }

}
