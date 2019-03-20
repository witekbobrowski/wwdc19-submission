//
//  UserService.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

class UserService {
    func fetch() -> [User] {
        return [
            User.👽, User.🐻, User.🐱, User.🐔, User.🐶, User.🐲, User.🦊,
            User.👻, User.🐨, User.🦁, User.🐵, User.🐼, User.🐷, User.💩,
            User.🐰, User.🤖, User.💀, User.🐯, User.🦖, User.🦄
        ]
    }
}

// The most epic user base
extension User {
    static var 👽: User { return User(name: "Alien", avatar: "👽") }
    static var 🐻: User { return User(name: "Bear", avatar: "🐻") }
    static var 🐱: User { return User(name: "Cat", avatar: "🐱") }
    static var 🐔: User { return User(name: "Chicken", avatar: "🐔") }
    static var 🐶: User { return User(name: "Dog", avatar: "🐶") }
    static var 🐲: User { return User(name: "Dragon", avatar: "🐲") }
    static var 🦊: User { return User(name: "Fox", avatar: "🦊") }
    static var 👻: User { return User(name: "Ghost", avatar: "👻") }
    static var 🐨: User { return User(name: "Koala", avatar: "🐨") }
    static var 🦁: User { return User(name: "Lion", avatar: "🦁") }
    static var 🐵: User { return User(name: "Monkey", avatar: "🐵") }
    static var 🐼: User { return User(name: "Panda", avatar: "🐼") }
    static var 🐷: User { return User(name: "Pig", avatar: "🐷") }
    static var 💩: User { return User(name: "Poo", avatar: "💩") }
    static var 🐰: User { return User(name: "Rabbit", avatar: "🐰") }
    static var 🤖: User { return User(name: "Robot", avatar: "🤖") }
    static var 💀: User { return User(name: "Skull", avatar: "💀") }
    static var 🐯: User { return User(name: "Tiger", avatar: "🐯") }
    static var 🦖: User { return User(name: "T-Rex", avatar: "🦖") }
    static var 🦄: User { return User(name: "Unicorn", avatar: "🦄") }
}
