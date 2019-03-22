//
//  QuackController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 22/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

class QuackController {

    private let quacksService: QuacksService

    init(quacksService: QuacksService = QuacksService()) {
        self.quacksService = quacksService
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
        quacksService.save(quack: quack)
        completion()
    }

}
