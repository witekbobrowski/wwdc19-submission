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
    private let wordIndex: [String: Int]

    init() {
        self.wordIndex = SentimentService.loadWords(from: "words", extension: "txt")
    }

    func sentiment(for text: String) -> Sentiment {
        // Using NLP Tagger perform text cleanup to extract words
        let words = bagOfWords(text: text)
        // Using NLP Tagger convert words to tokens
        let lemmas = words.keys.flatMap(lemmatize)
        // Retrive IDs for each token
        let ids = lemmas.compactMap { wordIndex[$0] }
        // Pad ID sequence to match required input lenght
        let input = pad(sequence: ids, toLenght: 100)
        // Predict sentiment using SentimentAnalysis model
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
            tag.map { words.append($0.rawValue) }
        }
        return words
    }

    private func pad(sequence: [Int], toLenght lenght: Int) -> [Int] {
        guard sequence.count < lenght else {
            return Array(sequence.prefix(lenght))
        }
        let padding = (0..<lenght - sequence.count).map { _ in 0 }
        return sequence + padding
    }

}

extension SentimentService {

    private static func loadWords(
        from file: String, extension fileExtension: String
    ) -> [String: Int] {
        var words = ["": 0]
        let url = Bundle.main.url(forResource: file, withExtension: fileExtension)
        let fileContents = try! String(contentsOf: url!)
        fileContents.split(separator: "\n").enumerated().forEach { (index, word) in
            words[String(word)] = index + 1
        }
        return words
    }

}
