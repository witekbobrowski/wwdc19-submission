//
//  UserPickerViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 23/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class UserPickerViewController: UIViewController {

    private let userService = UserService()

    private let pickerViewController = HorizontalPickerViewController()

    private var users = [User]() {
        didSet { reload(with: users) }
    }

    var current: User? {
        return pickerViewController.current.map { users[$0] }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        users = userService.fetch()
    }

}

extension UserPickerViewController {

    private func reload(with users: [User]) {
        pickerViewController.contentViewControllers = users.map { user in
            let viewController = AvatarViewController()
            viewController.avatar = user.avatar
            viewController.avatarBackgroundColor = .clear
            return viewController
        }
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        add(child: pickerViewController)
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(pickerViewController.view)
        NSLayoutConstraint.activate([
            pickerViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pickerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
