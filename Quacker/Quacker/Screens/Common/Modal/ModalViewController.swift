//
//  ModalViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    private let headerViewController = ModalHeaderViewController()

    private let containerView: UIView = create {
        $0.layer.cornerRadius = 24
        $0.backgroundColor = StyleSheet.Color.backgroundColor
    }
    private let contentView: UIView = create {
        $0.backgroundColor = .clear
    }

    var contentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.view.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard isMovingFromParent else { return }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.view.backgroundColor = .clear
        }
    }

}

extension ModalViewController {

    private func setupView() {
        view.backgroundColor = .clear
        headerViewController.delegate = self
        headerViewController.headerTitle = "Quack something"
        add(child: headerViewController)
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(containerView)
        [headerViewController.view, contentView].forEach(containerView.addSubview)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 512),

            headerViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerViewController.view.heightAnchor.constraint(equalToConstant: 44),

            contentView.topAnchor.constraint(equalTo: headerViewController.view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 256),
        ])
    }

}

extension ModalViewController: ModalHeaderViewControllerDelegate {
    func modalHeaderViewControllerDidSelectCancel(
        _ modalHeaderViewController: ModalHeaderViewController
    ) {
        dismiss(animated: true)
    }
}
