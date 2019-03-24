//
//  TimerViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    private let dateLabel: UILabel = create {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = StyleSheet.Color.secondaryTextColor
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private var timer: Timer?

    var date: Date? { didSet { update(with: date) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.update(with: self?.date)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
}

extension TimerViewController {

    private func update(with date: Date?) {
        dateLabel.text = date.map(formatted)
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func formatted(date: Date) -> String {
        let timeInterval = -date.timeIntervalSinceNow
        switch timeInterval {
        case ..<60:
            return "\(Int(timeInterval))s."
        case ..<3600:
            return "\(Int(timeInterval/60))min."
        case ..<86400:
            return "\(Int(timeInterval/3600))h."
        default:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY.MM.d HH:mm."
            return dateFormatter.string(from: date)
        }
    }

}
