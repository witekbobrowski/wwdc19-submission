//
//  TableViewCell.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    public var hostedView: UIView? {
        didSet {
            remove(old: oldValue)
            configure(new: hostedView)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        hostedView = nil
    }

    private func configure(new hostedView: UIView?) {
        guard let view = hostedView else { return }
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func remove(old hostedView: UIView?) {
        guard let view = hostedView else { return }
        view.removeFromSuperview()
    }

}
