//
//  UserPickerViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 23/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class UserPickerViewController: UIViewController {

    private let userService: UserService

    private let pickerViewController = HorizontalPickerViewController()

    private let titleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    private var users = [User]() {
        didSet { reload(with: users) }
    }

    var current: User? {
        return pickerViewController.current.map { users[$0] }
    }

    init(userService: UserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
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
        titleLabel.text = "Quack as:"
        add(child: pickerViewController)
        setupLayout()
    }

    private func setupLayout() {
        [titleLabel, pickerViewController.view].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.centerYAnchor.constraint(
                equalTo: pickerViewController.view.centerYAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: pickerViewController.view.leadingAnchor, constant: -12
            ),

            pickerViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pickerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerViewController.view.widthAnchor.constraint(equalToConstant: 128),
        ])
    }

}
