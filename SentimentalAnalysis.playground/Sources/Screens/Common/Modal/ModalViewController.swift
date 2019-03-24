//
//  ModalViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    func modalViewControllerDidExit(_ modalViewController: ModalViewController)
}

class ModalViewController: UIViewController {

    private let headerViewController = ModalHeaderViewController()

    private let containerView: UIView = create {
        $0.layer.cornerRadius = 24
        $0.backgroundColor = StyleSheet.Color.backgroundColor
    }
    private let contentView: UIView = create {
        $0.backgroundColor = .clear
    }

    weak var delegate: ModalViewControllerDelegate?
    var contentViewController: UIViewController? {
        didSet { reloadContent(old: oldValue, new: contentViewController) }
    }

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

    private func reloadContent(old: UIViewController?, new: UIViewController?) {
        // Remove old content, if existed
        if let viewController = old {
            viewController.view.removeFromSuperview()
            viewController.moveFromParent()
        }
        // Embed new content, if exists
        if let viewController = new {
            add(child: viewController)
            embed(new: viewController.view)
        }
        headerViewController.headerTitle = new?.title
    }

    private func embed(new hostedView: UIView) {
        contentView.addSubview(hostedView)
        NSLayoutConstraint.activate([
            hostedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func remove(old hostedView: UIView) {
        view.removeFromSuperview()
    }

    private func setupView() {
        view.backgroundColor = .clear
        headerViewController.delegate = self
        add(child: headerViewController)
        headerViewController.headerTitle = contentViewController?.title
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
        ])
    }

}

extension ModalViewController: ModalHeaderViewControllerDelegate {
    func modalHeaderViewControllerDidSelectCancel(
        _ modalHeaderViewController: ModalHeaderViewController
    ) {
        delegate?.modalViewControllerDidExit(self)
    }
}
