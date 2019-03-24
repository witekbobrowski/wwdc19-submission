//
//  SceneViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

public class SceneViewController: UIViewController {

    // Workaroud for broken Xcode Playgrounds...
    private let _modalViewController = ModalViewController()

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    public var contentViewController: UIViewController? {
        didSet {
            remove(old: oldValue)
            embed(new: contentViewController)
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideModal()
    }

}

extension SceneViewController {

    private func embed(new viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        add(child: viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(viewController.view, at: 0)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewController.view.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            viewController.view.widthAnchor.constraint(equalToConstant: 512)
        ])
    }

    private func remove(old viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        viewController.view.removeFromSuperview()
        viewController.moveFromParent()
    }

    private func setupView() {
        view.backgroundColor = StyleSheet.Color.backgroundColor
        setupModal()
    }

    private func setupModal() {
        _modalViewController.delegate = self
        add(child: _modalViewController)
        view.addSubview(_modalViewController.view)
        _modalViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _modalViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _modalViewController.view.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            _modalViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            _modalViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    func showModal(for viewController: UIViewController) {
        _modalViewController.contentViewController = viewController
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?._modalViewController.view.alpha = 1
        }
    }

    func hideModal() {
        UIView.animate(
            withDuration: 0.2,
            animations: { [weak self] in
                self?._modalViewController.view.alpha = 0
            }
        ) { [weak self] _ in
            self?._modalViewController.contentViewController = nil
        }
    }

}

extension SceneViewController: ModalViewControllerDelegate {
    func modalViewControllerDidExit(_ modalViewController: ModalViewController) {
        hideModal()
    }
}
