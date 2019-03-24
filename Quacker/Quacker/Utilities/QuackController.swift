//
//  QuackController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 22/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

class QuackController {

    private let userService: UserService
    private let quacksService: QuacksService
    private let sentimentService: SentimentService

    init(
        current: User? = nil,
        userService: UserService = UserService(),
        quacksService: QuacksService = QuacksService(),
        sentimentService: SentimentService = SentimentService()
    ) {
        self.quacksService = quacksService
        self.sentimentService = sentimentService
        current.map(<#T##transform: (User) throws -> U##(User) throws -> U#>)
    }

}

extension QuackController {

    var quacks: [Quack] {
        return quacksService.fetch()
    }

    func createQuack(with text: String, from user: User, completion: @escaping () -> Void) {
        let quack = Quack(
            text: text, date: Date(), sentiment: Sentiment(value: 0.5), user: user
        )
        sentimentService.sentiment(for: text)
        quacksService.save(quack: quack)
        completion()
    }

}
