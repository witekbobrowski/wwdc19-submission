//
//  QuacksService.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

class QuacksService {
    func fetch() -> [Quack] {
        return [
            Quack(
                text: "WWDC19 Scholarships reward talented students and STEM organization members with the opportunity to attend this year’s conference. Developers selected for a scholarship will receive a WWDC19 ticket, lodging for the conference, and one year of membership in the Apple Developer Program free of charge.",
                date: Date(),
                sentiment: Sentiment(value: 1),
                user: User.🤖
            ),
            Quack(
                text: "Your talent and enthusiasm could take you all the way to WWDC19. Build a Swift playground to showcase your ingenuity, answer a few questions with written responses, provide documentation, and submit.",
                date: Date(),
                sentiment: Sentiment(value: 1),
                user: User.🐔
            ),
            Quack(
                text: "Create an interactive scene in a Swift playground that can be experienced within three minutes using Swift Playgrounds 2.2 or Xcode 10.1. Be creative. If you need inspiration, use templates in Swift Playgrounds for a head start on more advanced creations. Make them your own by adding graphics, audio, and more.",
                date: Date(),
                sentiment: Sentiment(value: 1),
                user: User.🐵
            ),
            Quack(
                text: "Tell us about yourself.\nSign in to the application form with the Apple ID associated with your developer account. If you're under 18 years old, you will also be asked to enter contact information for your parent or legal guardian.",
                date: Date(),
                sentiment: Sentiment(value: 1),
                user: User.🐻
            ),
            Quack(
                text: "Provide school / membership information.\nIf you’re a student, provide your most recent class schedule or other most recent proof of enrollment (PDF, PNG, or JPG) and the contact information for your educational supervisor. If you’re a member of a STEM organization, provide your membership information (PDF, PNG, or JPG) and your local leader’s contact information. Documentation is accepted in all languages.",
                date: Date(),
                sentiment: Sentiment(value: 1),
                user: User.🐲
            )
        ]
    }
}
