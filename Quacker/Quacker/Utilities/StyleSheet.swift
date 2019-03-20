//
//  StyleSheet.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

struct StyleSheet {

    struct Color {
        static let backgroundColor = UIColor.blue
        static let textColor = UIColor.white
        static let secondaryTextColor = UIColor.white.withAlphaComponent(0.7)
    }

}

private extension UIColor {
    static let darkBlue: UIColor = #colorLiteral(red: 0.07058823529, green: 0.1058823529, blue: 0.1803921569, alpha: 1)
}
