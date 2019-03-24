//
//  InfoViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    private let titleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
        $0.text = "Welcome to my WWDC19 Scholarship submission!"
    }
    private lazy var contentLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = StyleSheet.Color.textColor
        $0.numberOfLines = 0
        $0.text = content
        $0.textAlignment = .center
    }
    private let sentimentalAnalysisTitleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
        $0.text = "Sentimental Analysis 🔬"
    }
    private lazy var sentimentalAnalysisContentLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = StyleSheet.Color.textColor
        $0.numberOfLines = 0
        $0.text = sentimentalAnalysisContent
        $0.textAlignment = .center
    }
    private let machineLearningTitleLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = StyleSheet.Color.textColor
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignCenters
        $0.text = "Machine Learning 🧠"
    }
    private lazy var machineLearningContentLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = StyleSheet.Color.textColor
        $0.numberOfLines = 0
        $0.text = machineLearningContent
        $0.textAlignment = .center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension InfoViewController {

    private func setupView() {
        title = "🦆 Quacker"
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }

    private func setupLayout() {
        [titleLabel, contentLabel,
         sentimentalAnalysisTitleLabel, sentimentalAnalysisContentLabel,
         machineLearningTitleLabel, machineLearningContentLabel]
            .forEach(view.addSubview)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),


            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            sentimentalAnalysisTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sentimentalAnalysisTitleLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12),

            sentimentalAnalysisContentLabel.topAnchor.constraint(equalTo: sentimentalAnalysisTitleLabel.bottomAnchor, constant: 8),
            sentimentalAnalysisContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sentimentalAnalysisContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            machineLearningTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            machineLearningTitleLabel.topAnchor.constraint(equalTo: sentimentalAnalysisContentLabel.bottomAnchor, constant: 12),

            machineLearningContentLabel.topAnchor.constraint(equalTo: machineLearningTitleLabel.bottomAnchor, constant: 8),
            machineLearningContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            machineLearningContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            machineLearningContentLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -19),
        ])

    }

    private var content: String {
        return """
        The goal of this project was to create a simple Twitter clone that \
        features Sentimental Analysis of the tweets. And this is exactly what it does! \
        Just like on twitter, you can tweet - or rather quack - whatever is currently \
        on your mind and share it with the world - or at least a couple of animoji \
        friends that are currently registered to Quacker ;). But there is one thing \
        that makes Quacker special...
        """
    }

    private var sentimentalAnalysisContent: String {
        return """
        Every message carries its own sentimental value, which means that the \
        content represented by this message could be positive, negative or something \
        in between. We humans do not have problems with detecting those emotions in \
        and once we read the tweet (or a quack!) it appears for us rather clear what \
        a given person ment or felt while writing it. But having a computer detect it \
        is a completely different story...
        """
    }

    private var machineLearningContent: String {
        return """
        And here comes the power of Machine Learning! With a fairly simple neural \
        network we are able to predict the emotion of a message. Using Natural \
        Language Processing we strip down the senteces to feed the model to get a \
        prediction, but that prediction will only be valid if the model was trained \
        on a large amount of data. Unfortunately this wasnt possible here, since \
        we have to meet the 25MB limit of the submition, and this had an impact \
        on my models accuracy due to the need of making it simpler than it used to be. \
        Having said that...

        I really hope you will enjoy this project, I did my best to make the \
        experience as pleasing as possible. Thank you!
        """
    }

}
