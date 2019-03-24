//
//  User.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct User: Codable {
    let username: String
    let fullName: String
    let avatar: String

    public init(username: String, fullName: String, avatar: String) {
        self.username = username
        self.fullName = fullName
        self.avatar = avatar
    }
}

extension User {
    init(name: String, avatar: String) {
        self.init(
            username: name.lowercased() + "\(Int.random(in: 0...2000))",
            fullName: name,
            avatar: avatar
        )
    }
}
