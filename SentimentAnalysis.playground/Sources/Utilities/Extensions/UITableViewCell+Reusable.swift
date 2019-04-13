//
//  UITableViewCell+Reusable.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

// Helper wrapper methods to laverage generics in UITableView
extension UITableView {
    /// Register cell type as reusable
    func register<Cell: UITableViewCell>(_ cellType: Cell.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
    /// Dequeue reusable cell for given indexPath
    func dequeue<Cell: UITableViewCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(
            withIdentifier: String(describing: cellType), for: indexPath
        ) as! Cell
    }
}
