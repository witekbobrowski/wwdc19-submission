import UIKit
import PlaygroundSupport
import CoreML

let label = UILabel()
label.frame = CGRect(x: 150, y: 200, width: 300, height: 500)
label.text = "Hello World!"
label.textAlignment = .center
label.textColor = .black
label.backgroundColor = .white
label.numberOfLines = 0

let sentimentalAnalysis = SentimentalAnalysis()

label.text = sentimentalAnalysis.model.description

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = label
