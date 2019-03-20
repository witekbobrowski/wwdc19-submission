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
        $0.baselineAdjustment = .alignCenters
    }

    private let progressView: CircullarProgressView = create {
        $0.colors = [.red, .orange, .green]
    }

    private let valueLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
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
        iconLabel.text = sentiment?.icon
        valueLabel.text = (sentiment?.normalized).map {
            "\(Int(($0 * 100).rounded()))%"
        }
        progressView.value = sentiment?.normalized
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        setupLayuot()
    }

    private func setupLayuot() {
        [progressView, iconLabel, valueLabel].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.widthAnchor.constraint(equalTo: progressView.heightAnchor, multiplier: 1),

            iconLabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 5),
            iconLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 5),
            iconLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -5),
            iconLabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -5),

            valueLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
