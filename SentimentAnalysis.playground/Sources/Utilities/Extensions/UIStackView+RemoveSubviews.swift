//
//  UIStackView+RemoveSubviews.swift
//  Quacker
//
//  Created by Witek Bobrowski on 23/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

extension UIStackView {
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
