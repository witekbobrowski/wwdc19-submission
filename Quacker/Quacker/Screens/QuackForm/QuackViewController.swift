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

    private let textViewController = TextViewController()
    private let quackProgressViewController = QuackProgressViewController()
    private let quackButtonViewController = NeonButtonViewController()

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
        quackProgressViewController.value = 0.1
        [textViewController, quackButtonViewController, quackProgressViewController].forEach(add)
        quackButtonViewController.button.setTitle("Quack it!", for: .normal)
        quackButtonViewController.button.addTarget(
            self, action: #selector(quackButtonDidTap), for: .touchUpInside
        )
        setupLayout()
    }

    private func setupLayout() {
        [textViewController.view, quackProgressViewController.view, quackButtonViewController.view].forEach(view.addSubview)
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

            quackProgressViewController.view.centerYAnchor.constraint(
                equalTo: quackButtonViewController.view.centerYAnchor
            ),
            quackProgressViewController.view.trailingAnchor.constraint(
                equalTo: quackButtonViewController.view.leadingAnchor, constant: -16
            ),
            quackProgressViewController.view.widthAnchor.constraint(equalToConstant: 24),
            quackProgressViewController.view.heightAnchor.constraint(equalToConstant: 24),


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
