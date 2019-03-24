//
//  HomeFooterViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 24/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class HomeFooterViewController: UIViewController {

    private let titleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = StyleSheet.Color.textColor
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
        $0.text = "WWDC"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension HomeFooterViewController {

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
