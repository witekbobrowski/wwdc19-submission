//
//  Sentiment.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import Foundation

struct Sentiment: Codable {
    let value: Double
}

extension Sentiment {
    var normalized: Double {
        return max(min(value, 1), 0)
    }
    var icon: String {
        switch value {
        case ..<0.1: return "😭"
        case 0.1..<0.2: return "😰"
        case 0.2..<0.3: return "😥"
        case 0.3..<0.4: return "🙁"
        case 0.4..<0.6: return "😐"
        case 0.6..<0.7: return "🙂"
        case 0.7..<0.8: return "😌"
        case 0.9...: return "🤩"
        default: return ""
        }
    }
}
