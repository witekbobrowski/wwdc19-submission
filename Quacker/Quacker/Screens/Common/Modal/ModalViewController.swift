//
//  ModalViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    private let containerView: UIView = create {
        $0.layer.cornerRadius = 24
        $0.backgroundColor = .red
    }
    private let contentView: UIView = create {
        $0.backgroundColor = .clear
    }

    var contentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.view.backgroundColor = .clear
        }
    }

}

extension ModalViewController {

    private func setupView() {
        view.backgroundColor = .clear
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(containerView)
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 512),

            contentView.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }

}

