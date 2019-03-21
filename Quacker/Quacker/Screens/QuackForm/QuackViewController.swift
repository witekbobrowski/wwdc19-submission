//
//  QuackFormViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol QuackFormViewControllerDelegate: class {
    func quackFormViewControllerDidSelectQuack(
        _ quackFormViewController: QuackFormViewController
    )
}

class QuackFormViewController: UIViewController {

    private let quackButtonViewController = NeonButtonViewController()

    private let textView: UITextView = create {
        $0.textColor = StyleSheet.Color.textColor
        $0.layer.cornerRadius = 8
        $0.backgroundColor = StyleSheet.Color.textColor.withAlphaComponent(0.05)
    }

    weak var delegate: QuackFormViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func quackButtonDidTap(_ button: UIButton) {
        delegate?.quackFormViewControllerDidSelectQuack(self)
    }

}

extension QuackFormViewController {

    private func setupView() {
        title = "Quack something"
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        quackButtonViewController.button.setTitle("Quack it!", for: .normal)
        quackButtonViewController.button.addTarget(
            self, action: #selector(quackButtonDidTap), for: .touchUpInside
        )
        setupLayout()
    }

    private func setupLayout() {
        [textView, quackButtonViewController.view].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 128),

            quackButtonViewController.view.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            quackButtonViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            quackButtonViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }

}
