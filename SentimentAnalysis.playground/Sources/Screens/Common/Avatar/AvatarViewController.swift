//
//  AvatarViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController {

    private let avatarLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 40)
        $0.adjustsFontSizeToFitWidth = true
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        $0.baselineAdjustment = .alignCenters
    }

    var avatar: String? { didSet { update(with: avatar) } }
    var avatarBackgroundColor: UIColor? {
        set { avatarLabel.backgroundColor = newValue }
        get { return avatarLabel.backgroundColor }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension AvatarViewController {

    private func update(with avatar: String?) {
        avatarLabel.text = avatar
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarLabel)
        NSLayoutConstraint.activate([
            avatarLabel.topAnchor.constraint(equalTo: view.topAnchor),
            avatarLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avatarLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            avatarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

}
