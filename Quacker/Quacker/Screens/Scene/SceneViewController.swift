//
//  SceneViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class SceneViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    var contentViewController: UIViewController? {
        didSet {
            remove(old: oldValue)
            embed(new: contentViewController)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension SceneViewController {

    private func embed(new viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        add(child: viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
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
    }

}
