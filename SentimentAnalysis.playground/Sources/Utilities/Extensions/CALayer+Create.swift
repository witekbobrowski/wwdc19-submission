//
//  CALayer+Create.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

func create<Layer: CALayer>(configure: (Layer) -> Void) -> Layer {
    let layer = Layer()
    configure(layer)
    return layer
}
