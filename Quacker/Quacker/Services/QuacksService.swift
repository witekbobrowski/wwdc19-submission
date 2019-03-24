//
//  QuacksService.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

class QuacksService {

    private var storage = [Quack]()

    func save(quack: Quack) {
        storage.insert(quack, at: 0)
    }
    func fetch() -> [Quack] {
        return storage.sorted { $0.date > $1.date }
    }
}
