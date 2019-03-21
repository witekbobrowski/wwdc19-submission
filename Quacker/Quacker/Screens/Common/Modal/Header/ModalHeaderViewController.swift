//
//  ModalHeaderViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol ModalHeaderViewControllerDelegate: class {
    func modalHeaderViewControllerDidSelectCancel(
        _ modalHeaderViewController: ModalHeaderViewController
    )
}

class ModalHeaderViewController: UIViewController {

    private let titleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
    }

    private let cancelButton: UIButton = create {
        $0.tintColor = StyleSheet.Color.secondaryTextColor
        $0.setImage(StyleSheet.Asset.closeIcon, for: .normal)
        $0.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
    }

    weak var delegate: ModalHeaderViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func cancelButtonDidTap(_ sender: UIButton) {
        delegate?.modalHeaderViewControllerDidSelectCancel(self)
    }

}

extension ModalHeaderViewController {
    var headerTitle: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
}

extension ModalHeaderViewController {

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }

    private func setupLayout() {
        [titleLabel, cancelButton].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cancelButton.heightAnchor.constraint(equalToConstant: 28),
            cancelButton.widthAnchor.constraint(equalToConstant: 28),
        ])
    }

}
