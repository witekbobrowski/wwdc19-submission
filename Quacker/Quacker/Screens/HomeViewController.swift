//
//  HomeViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let feedViewController = FeedViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension HomeViewController {
    private func setupView() {
        view.backgroundColor = StyleSheet.Color.backgroundColor
        addChild(feedViewController)
        feedViewController.didMove(toParent: self)
        view.addSubview(feedViewController.view)
        NSLayoutConstraint.activate([
            feedViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            feedViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
