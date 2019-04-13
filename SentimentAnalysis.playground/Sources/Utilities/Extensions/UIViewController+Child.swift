//
//  UIViewController+Child.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(child viewController: UIViewController) {
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
}

extension UIViewController {
    func moveFromParent() {
        removeFromParent()
        willMove(toParent: nil)
    }
}
