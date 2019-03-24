//
//  SentimentService.swift
//  Quacker
//
//  Created by Witek Bobrowski on 24/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation
import CoreML
import NaturalLanguage

class SentimentService {

    private let model = SentimentalAnalysis()

    init() {}

    func sentiment(for text: String) -> Sentiment {
        let words = bagOfWords(text: text)
        let lemmas = words.keys.flatMap(lemmatize)
        let input = SentimentalAnalysisInput(
            words: try! MLMultiArray(shape: [100, 1], dataType: .double)
        )
        for index in 0..<100 {
            input.words[index] = NSNumber(value: Int.random(in: 0...2000))
        }
//        let prediction = try! model.prediction(input: input)
        return Sentiment(value: 0)
    }

}

extension SentimentService {

    private func bagOfWords(text: String) -> [String: Double] {
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = text
        var bagOfWords: [String: Double] = [:]
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(
            in: range, unit: .word, scheme: .tokenType, options: options
        ) { tag, tokenRange, stop in
            let word = (text as NSString).substring(with: tokenRange)
            bagOfWords[word, default: 0] += 1
        }
        return bagOfWords
    }

    private func lemmatize(word: String) -> [String] {
        let tagger = NSLinguisticTagger(tagSchemes: [.lemma], options: 0)
        tagger.string = word
        var words: [String] = []
        let range = NSRange(location: 0, length: word.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(
            in: range, unit: .word, scheme: .lemma, options: options
        ) { tag, tokenRange, stop in
            if let lemma = tag?.rawValue {
                words.append(lemma)
            }
//            words.append((word as NSString).substring(with: tokenRange))
        }
        return words
    }
}
