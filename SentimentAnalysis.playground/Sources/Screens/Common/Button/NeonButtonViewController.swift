//
//  NeonButtonViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class NeonButtonViewController: UIViewController {

    private let upperLayer: CAShapeLayer = create {
        $0.strokeColor = StyleSheet.Color.tintColor.cgColor
        $0.fillColor = UIColor.clear.cgColor
        $0.lineCap = .round
        $0.lineWidth = 1.5
    }

    private let lowerLayer: CAShapeLayer = create {
        $0.strokeColor = StyleSheet.Color.tintColor.cgColor
        $0.fillColor = UIColor.clear.cgColor
        $0.lineCap = .round
        $0.lineWidth = 1.5
    }

    let button: UIButton = create {
        $0.setTitleColor(StyleSheet.Color.tintColor, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [upperLayer, lowerLayer].forEach { $0.frame = view.bounds }
        upperLayer.path = getPathForUpperLayer(in: view.bounds)
        lowerLayer.path = getPathForLowerLayer(in: view.bounds)
    }

}

extension NeonButtonViewController {

    private var radius: CGFloat { return 5 }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        [upperLayer, lowerLayer].forEach(view.layer.addSublayer)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func getPathForUpperLayer(in frame: CGRect) -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.midY - 2))
        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addArc(
            withCenter: CGPoint(x: radius, y: radius), radius: radius,
            startAngle: .pi, endAngle: .pi * 1.5, clockwise: true
        )
        path.addLine(to: CGPoint(x: frame.maxX - radius, y: 0))
        path.addArc(
            withCenter: CGPoint(x: frame.maxX - radius, y: radius), radius: radius,
            startAngle: .pi * 1.5, endAngle: .pi * 2, clockwise: true
        )
        path.addLine(to: CGPoint(x: frame.maxX, y: frame.midY - 2))
        return path.cgPath
    }

    private func getPathForLowerLayer(in frame: CGRect) -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.midY + 2))
        path.addLine(to: CGPoint(x: 0, y: frame.maxY - radius))
        path.addArc(
            withCenter: CGPoint(x: radius, y: frame.maxY - radius), radius: radius,
            startAngle: .pi, endAngle: .pi * 0.5, clockwise: false
        )
        path.addLine(to: CGPoint(x: frame.maxX - radius, y: frame.maxY))
        path.addArc(
            withCenter: CGPoint(x: frame.maxX - radius, y: frame.maxY - radius), radius: radius,
            startAngle: .pi * 0.5, endAngle: 0, clockwise: false
        )
        path.addLine(to: CGPoint(x: frame.maxX, y: frame.midY + 2))
        return path.cgPath
    }

}
