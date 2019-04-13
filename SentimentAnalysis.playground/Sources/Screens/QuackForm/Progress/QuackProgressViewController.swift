//
//  QuackProgressViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class QuackProgressViewController: UIViewController {

    private let backgroundShapeLayer: CAShapeLayer = create {
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeColor = StyleSheet.Color.textColor.withAlphaComponent(0.1).cgColor
        $0.lineWidth = 2
    }

    private let progressShapeLayer: CAShapeLayer = create {
        $0.fillColor = UIColor.clear.cgColor
        $0.lineWidth = 2
        $0.lineCap = .round
    }

    var value: Double = 0 { didSet { updateProgress(for: value) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [backgroundShapeLayer, progressShapeLayer].forEach { $0.frame = view.bounds }
        backgroundShapeLayer.path = getPath(
            in: view.bounds, startAngle: 0, endAngle: 2 * .pi
        )
        updateProgress(for: value)
    }


}

extension QuackProgressViewController {

    private func updateProgress(for value: Double) {
        let distance: CGFloat = CGFloat(value) * 2 * .pi
        let start: CGFloat = 1.5 * .pi
        let angle = distance < 0.5 * .pi ? start + distance : distance + start - 2 * .pi - 0.0000001
        progressShapeLayer.path = getPath(
            in: view.bounds, startAngle: start, endAngle: angle
        )
        let strokeColor = value < 0.8 ? StyleSheet.Color.tintColor : (value < 0.95 ? .orange : .red)
        progressShapeLayer.strokeColor = strokeColor.cgColor
    }

    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        [backgroundShapeLayer, progressShapeLayer].forEach(view.layer.addSublayer)
    }

    private func getPath(in frame: CGRect, startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
        let path = UIBezierPath()
        path.addArc(
            withCenter: CGPoint(x: frame.midX, y: frame.midY),
            radius: frame.width/2 - 1, startAngle: startAngle, endAngle: endAngle,
            clockwise: true
        )
        return path.cgPath
    }

}
