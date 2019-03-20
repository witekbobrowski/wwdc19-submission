//
//  HomeHeaderViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class HomeHeaderViewController: UIViewController {

    private let titleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
        $0.text = "Latest Quacks"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension HomeHeaderViewController {

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

}
