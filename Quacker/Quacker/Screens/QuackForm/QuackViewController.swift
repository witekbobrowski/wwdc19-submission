//
//  QuackFormViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol QuackFormViewControllerDelegate: class {
    func quackFormViewController(
        _ quackFormViewController: QuackFormViewController, didQuacked quack: String?
    )
}

class QuackFormViewController: UIViewController {

    private let quackButtonViewController = NeonButtonViewController()
    private let textViewController = TextViewController()

    weak var delegate: QuackFormViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func quackButtonDidTap(_ button: UIButton) {
        delegate?.quackFormViewController(
            self, didQuacked: textViewController.text
        )
    }

}

extension QuackFormViewController {

    private func setupView() {
        title = "Quack something"
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        [textViewController, quackButtonViewController].forEach(add)
        quackButtonViewController.button.setTitle("Quack it!", for: .normal)
        quackButtonViewController.button.addTarget(
            self, action: #selector(quackButtonDidTap), for: .touchUpInside
        )
        setupLayout()
    }

    private func setupLayout() {
        [textViewController.view, quackButtonViewController.view].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            textViewController.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16
            ),
            textViewController.view.topAnchor.constraint(
                equalTo: view.topAnchor, constant: 8
            ),
            textViewController.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16
            ),
            textViewController.view.heightAnchor.constraint(equalToConstant: 128),

            quackButtonViewController.view.topAnchor.constraint(
                equalTo: textViewController.view.bottomAnchor, constant: 16
            ),
            quackButtonViewController.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16
            ),
            quackButtonViewController.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -16
            ),
        ])
    }

}
