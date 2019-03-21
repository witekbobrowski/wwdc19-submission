//
//  QuackViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class QuackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension QuackViewController {

    private func setupView() {
        title = "Quack something"
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }

    private func setupLayout() {

    }

}
