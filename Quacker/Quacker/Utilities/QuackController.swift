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
    private let sentimentService: SentimentService
    let userService: UserService

    var quacks: [Quack] {
        return quacksService.fetch()
    }

    init(
        current: User? = nil,
        quacksService: QuacksService = QuacksService(),
        sentimentService: SentimentService = SentimentService(),
        userService: UserService = UserService()
    ) {
        self.quacksService = quacksService
        self.sentimentService = sentimentService
        self.userService = userService
        current.map { userService.current = $0 }
        loadMocks()
    }

    func createQuack(
        with text: String,
        from user: User,
        at date: Date,
        completion: @escaping () -> Void
    ) {
        let quack = Quack(
            text: text, date: date, sentiment: sentimentService.sentiment(for: text), user: user
        )
        quacksService.save(quack: quack)
        completion()
    }

}

// MARK: - Mocks
extension QuackController {

    private func loadMocks() {
        mocks.forEach { mock in
            let (text, date, user) = mock
            createQuack(with: text, from: user, at: date, completion: {})
        }
    }

    private var mocks: [(String, Date, User)] {
        // Thanks @DalaiLama for Tweets
        return [
            (
                "We may sometimes feel that we can’t do much as individuals, but humanity is made up of individuals; we can make a difference. As individuals we can influence our own families. Our families can influence our communities and our communities can influence our nations.",
                Date(timeInterval: -6321, since: Date()),
                User.🤖
            ),
            (
                "We won’t bring about peace in the world merely by praying for it; we have to take steps to tackle the violence and corruption that disrupt peace. We can’t expect change if we don’t take action.",
                Date(timeInterval: -8160, since: Date()),
                User.👽
            ),
            (
                "The first drawback of anger is that it destroys our inner peace; the second is that it distorts our view of reality. If we think about this and come to understand that anger is really unhelpful, that it is only destructive, we can begin to distance ourselves from anger.",
                Date(timeInterval: -506, since: Date()),
                User.🐵
            ),
            (
                "Compassion is something really worthwhile. It is not just a religious or spiritual subject, not a matter of ideology. It is not a luxury, it is a necessity.",
                Date(timeInterval: -2500, since: Date()),
                User.💀
            ),
        ]
    }

}
