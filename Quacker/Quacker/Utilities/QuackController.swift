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
        return [
            (
                "Wishing a Happy St. Patrick’s Day to everyone celebrating around the world, especially our Apple family in Ireland — 6,000 strong! We’re so proud to call Cork our home. Sláinte! ☘️",
                Date(timeInterval: -6321, since: Date()),
                User.🤖
            ),
            (
                "Steve’s vision is reflected all around us at Apple Park. He would have loved it here, in this place he dreamed up — the home and inspiration for Apple’s future innovations. We miss him today on his 64th birthday, and every day.",
                Date(timeInterval: -8160, since: Date()),
                User.👽
            ),
            (
                "100 years ago today the Grand Canyon became a national park. It is a source of wonder and inspiration — one of America’s greatest treasures. “In God's wildness lies the hope of the world.” — John Muir #shotoniPhone by @austinmann",
                Date(timeInterval: -506, since: Date()),
                User.🐵
            ),
            (
                "Phone photographers from all over the world have dazzled us with their talent and passion. The photos are remarkable! Congratulations to those behind the winning submissions, and thanks to everyone for participating.",
                Date(timeInterval: -2500, since: Date()),
                User.💀
            ),
        ]
    }

}
