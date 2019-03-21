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
        static let backgroundColor: UIColor = .darkBlue
        static let textColor: UIColor = .white
        static let secondaryTextColor = UIColor.white.withAlphaComponent(0.7)
        static let tintColor: UIColor = .neonBlue
    }

}

private extension UIColor {
    static let darkBlue: UIColor = #colorLiteral(red: 0.07058823529, green: 0.1058823529, blue: 0.1803921569, alpha: 1)
    static let neonBlue: UIColor = #colorLiteral(red: 0.2705882353, green: 0.462745098, blue: 0.9843137255, alpha: 1)
}
