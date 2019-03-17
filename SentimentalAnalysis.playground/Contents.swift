import UIKit
import PlaygroundSupport
import CoreML

let label = UILabel()
label.frame = CGRect(x: 150, y: 200, width: 200, height: 200)
label.text = "Hello World!"
label.textAlignment = .center
label.textColor = .black
label.backgroundColor = .white



//label.text =

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = label
