//
//  UIView+Create.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

func create<View: UIView>(configure: (View) -> Void = { _ in }) -> View {
    let view = View()
    view.translatesAutoresizingMaskIntoConstraints = false
    configure(view)
    return view
}
