//
//  User.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let fullName: String
    let avatar: String
    var quacks: [String]
}
