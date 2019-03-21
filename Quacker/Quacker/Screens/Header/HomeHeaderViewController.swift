//
//  HomeHeaderViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol HomeHeaderViewControllerDelegate: class {
    func homeHeaderViewControllerDidSelectInfo(
        _ homeHeaderViewController: HomeHeaderViewController
    )
    func homeHeaderViewControllerDidSelectQuack(
        _ homeHeaderViewController: HomeHeaderViewController
    )
}

class HomeHeaderViewController: UIViewController {

    private let infoButtonViewController = NeonButtonViewController()
    private let quackButtonViewController = NeonButtonViewController()

    private let titleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
        $0.text = "Latest Quacks"
    }

    weak var delegate: HomeHeaderViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func infoButtonDidTap(_ button: UIButton) {
        delegate?.homeHeaderViewControllerDidSelectInfo(self)
    }

    @objc private func quackButtonDidTap(_ button: UIButton) {
        delegate?.homeHeaderViewControllerDidSelectQuack(self)
    }

}

extension HomeHeaderViewController {

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        add(child: quackButtonViewController)
        infoButtonViewController.button.setTitle("Info", for: .normal)
        infoButtonViewController.button.addTarget(
            self, action: #selector(infoButtonDidTap), for: .touchUpInside
        )
        quackButtonViewController.button.setTitle("Quack", for: .normal)
        quackButtonViewController.button.addTarget(
            self, action: #selector(quackButtonDidTap), for: .touchUpInside
        )
        setupLayout()
    }

    private func setupLayout() {
        [infoButtonViewController.view, titleLabel, quackButtonViewController.view]
            .forEach(view.addSubview)
        NSLayoutConstraint.activate([
            infoButtonViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoButtonViewController.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16
            ),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            quackButtonViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quackButtonViewController.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16
            )
        ])
    }

}
