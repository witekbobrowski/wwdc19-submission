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

    private let model = SentimentalAnalysisModelFP16()
    private let wordIndex: [String: Int]

    private var inputSize: Int { return 100 }

    init() {
        self.wordIndex = SentimentService.loadWords(from: "words", extension: "txt")
    }

    func sentiment(for text: String) -> Sentiment {
        // Using NLP Tagger perform text cleanup to extract words
        let words = bagOfWords(text: text)
        // Using NLP Tagger convert words to tokens
        let lemmas = words.map(lemmatize)
        // Retrive IDs for each token
        let ids = lemmas.map { wordIndex[$0] ?? 0 }
        // Pad ID sequence to match required input lenght
        let input = pad(sequence: ids, toLenght: inputSize)
        // Predict sentiment using SentimentAnalysis model
        let prediction = try! model.prediction(
            input1: [inputSize].multiArray!,
            lstm_11_h_in: input.multiArray!,
            lstm_11_c_in: nil
        )
        return Sentiment(value: Double(truncating: prediction.sentiment[0]))
    }

}

extension SentimentService {

    private func bagOfWords(text: String) -> [String] {
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = text
        var words: [String] = []
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .omitOther]
        tagger.enumerateTags(
            in: range, unit: .word, scheme: .tokenType, options: options
        ) { tag, tokenRange, stop in
            let word = (text as NSString).substring(with: tokenRange)
            words.append(word.lowercased())
        }
        return words
    }

    private func lemmatize(word: String) -> String {
        let tagger = NSLinguisticTagger(tagSchemes: [.lemma], options: 0)
        tagger.string = word
        var lemma: String?
        let range = NSRange(location: 0, length: word.utf16.count)
        let options: NSLinguisticTagger.Options = []
        tagger.enumerateTags(
            in: range, unit: .word, scheme: .lemma, options: options
        ) { tag, tokenRange, stop in
            lemma = tag?.rawValue ?? ""
        }
        return lemma ?? word
    }

    private func pad(sequence: [Int], toLenght lenght: Int) -> [Int] {
        guard sequence.count < lenght else {
            return Array(sequence.prefix(lenght))
        }
        let padding = (0..<lenght - sequence.count).map { _ in 0 }
        return padding + sequence
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

extension Array where Element == Int {
    var multiArray: MLMultiArray? {
        let array = try? MLMultiArray(shape: [NSNumber(value: count)], dataType: .double)
        enumerated().forEach { array?[$0] = NSNumber(value: $1) }
        return array
    }
}
