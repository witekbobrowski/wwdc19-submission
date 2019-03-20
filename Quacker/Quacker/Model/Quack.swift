//
//  Quack.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

struct Quack: Codable {
    let text: String
    let date: Date
    let sentiment: Sentiment
    let user: User
}
