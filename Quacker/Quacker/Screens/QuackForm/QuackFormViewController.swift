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
        _ quackFormViewController: QuackFormViewController,
        didQuacked quack: String?,
        as user: User?
    )
}

class QuackFormViewController: UIViewController {

    private let textViewController = TextViewController()
    private let userPickerViewController = UserPickerViewController()
    private let progressViewController = QuackProgressViewController()
    private let quackButtonViewController = NeonButtonViewController()

    weak var delegate: QuackFormViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func quackButtonDidTap(_ button: UIButton) {
        delegate?.quackFormViewController(
            self, didQuacked: textViewController.text, as: userPickerViewController.current
        )
    }

}

extension QuackFormViewController {

    private func setupView() {
        title = "Quack something"
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        progressViewController.value = 0
        textViewController.delegate = self
        [textViewController, quackButtonViewController, progressViewController].forEach(add)
        quackButtonViewController.button.setTitle("Quack it!", for: .normal)
        quackButtonViewController.button.addTarget(
            self, action: #selector(quackButtonDidTap), for: .touchUpInside
        )
        setupLayout()
    }

    private func setupLayout() {
        [textViewController.view, userPickerViewController.view,
         progressViewController.view, quackButtonViewController.view]
            .forEach(view.addSubview)
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


            userPickerViewController.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16
            ),
            userPickerViewController.view.topAnchor.constraint(
                equalTo: textViewController.view.bottomAnchor, constant: 8
            ),
            userPickerViewController.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -16
            ),

            progressViewController.view.centerYAnchor.constraint(
                equalTo: quackButtonViewController.view.centerYAnchor
            ),
            progressViewController.view.trailingAnchor.constraint(
                equalTo: quackButtonViewController.view.leadingAnchor, constant: -16
            ),
            progressViewController.view.widthAnchor.constraint(equalToConstant: 24),
            progressViewController.view.heightAnchor.constraint(equalToConstant: 24),


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

extension QuackFormViewController: TextViewControllerDelegate {
    func textViewController(_ textViewController: TextViewController, didChange text: String) {
        let ratio = Double(text.count) / Double(textViewController.characterLimit)
        progressViewController.value = max(min(ratio, 1), 0)
    }
}
